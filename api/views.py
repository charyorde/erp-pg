# Create your views here.
from webapp.models import Institution, Transaction
from hashlib import md5
from helpers.http import HttpResponseUnauthorized, HttpResponseCreated
from django.http import HttpResponseNotFound, HttpResponse
from simplejson import dumps

def add_transaction(request):
    req_code = request.POST.get('code', '')
    req_digest = request.POST.get('digest', '')
    req_amount = float(request.POST.get('amount', 0.0))
    req_identifier = request.POST.get('identifier', '')

    try:
        institution = Institution.objects.get(code__iexact=req_code)
        auth_digest = _txn_digest(request.POST)
        
        # authenticate request
        if auth_digest == req_digest:
            # authentication success
            txn = Transaction()
            txn.amount = str(req_amount) # floats need to be converted to str first
            txn.institution = institution
            txn.identifier = req_identifier
            txn.save()

            return HttpResponseCreated(dumps({'status': 'OK', 'tpin': txn.tpin}), mimetype='application/json')
        else:
            return HttpResponseUnauthorized(dumps({'status': 'ERR', 'message': 'Unauthorized'}), mimetype='application/json')
    except Institution.DoesNotExist:
        # what to do if the institution was not found
        return HttpResponseUnauthorized(dumps({'status': 'ERR', 'message': 'Unauthorized'}), mimetype='application/json')

def view_transaction(request, tpin):
    req_code = request.POST.get('code', '')
    req_tpin = tpin

    try:
        institution = Institution.objects.get(code__iexact=req_code)
        
        txn = Transaction.objects.get(institution=institution, tpin=req_tpin)
        return HttpResponse(dumps({'status': 'OK', 'tpin': txn.tpin, \
            'identifier': txn.identifier, 'amount': float(txn.amount), 'paid': txn.paid, \
            'teller_no': txn.teller_no }), mimetype='application/json')
    except Institution.DoesNotExist:
        # what to do if the institution was not found
        return HttpResponseUnauthorized(dumps({'status': 'ERR', 'message': 'Unauthorized'}), mimetype='application/json')
    except Transaction.DoesNotExist:
        return HttpResponseNotFound(dumps({'status':'ERR', 'message':'Not Found'}))

def _txn_digest(params):
    """Calculates an authentication hash based on several parameters"""
    req = dict([[key, params.get(key, '')] for key in ['code', 'identifier', 'amount']])
    
    institution = Institution.objects.get(code__iexact=req['code'])
    text = ":".join([req[x] for x in ['code', 'identifier', 'amount']] \
        + [institution.secret])
    return md5(text).hexdigest().upper()
