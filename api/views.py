# Create your views here.
from webapp.models import Institution, Transaction
from hashlib import md5
from helpers.http import HttpResponseUnauthorized, HttpResponseCreated
from django.http import HttpResponseNotFound, HttpResponse, HttpRequest, QueryDict
from django.utils import simplejson as json
from simplejson import dumps, JSONDecodeError

from api.queues import Tasks
from api.tasks import insert_transaction
from api.tasks import PostTransaction as pt

def add_transaction(request):
    """ Parses and add a new transaction from external
	application for processing.
	
	Example using CURL in python dict format:
	curl -v -H "Content-Type: application/json" -X POST \
	--data 'code=UNIA;digest=5D316CD2311678A1B12F6152988F3097;amount=0.0;identifier= ; \
	fees={"fees":[("status","pending"),("timeout":120)], \
	"hostel":[("status","pending"),("timeout", 60)]}' \
	-u banker:banker http://127.0.0.1:8000/api/transaction/add/ > post_data.txt
	 
	A simple example using json would be:
	curl -v -H "Content-Type: application/json" -X POST \
	--data 'code=UNIA;digest=5D316CD2311678A1B12F6152988F3097;amount=0.0;identifier= ;
	fees={"status":"pending","timeout":120}' 
	-u banker:banker http://127.0.0.1:8000/api/transaction/add/ > post_data.txt 
	  
	A complex json example will be:
	curl -v -H "Content-Type: application/json" -X POST \
	--data 'code=UNIA;digest=5D316CD2311678A1B12F6152988F3097;amount=0.0;identifier= ; \
	fees={"fees":{"status":"pending","timeout":120}, \
	"hostel":{"status":"pending","timeout": 60}}' 
	-u banker:banker http://127.0.0.1:8000/api/transaction/add/ > post_data.txt
	
	"""
    req_code = request.POST.get('code', '') #institution code
    req_digest = request.POST.get('digest', '')
    req_amount = float(request.POST.get('amount', 0.0))
    req_identifier = request.POST.get('identifier', '')
    #req_fees = request.POST.get('fees', {})
    #req_fees = json.loads(request.POST.get('fees', ''))
    #req_fees = request.POST['fees']
    req_fees = {}
    #t = tasks.Tasks()
    auth_digest = _txn_digest(request.POST)
	
	# todo: Handle IntegrityError(https://code.djangoproject.com/wiki/IntegrityError)
    try:
		req_fees = json.loads(request.POST['fees'])
		if req_fees != None:
			pass
    except (KeyError, TypeError, JSONDecodeError):
		print HttpResponse("Malformed data request.")
		#print req_fees

    try:
        institution = Institution.objects.get(code__iexact=req_code)
        
        # authenticate request
        if auth_digest == req_digest:
            # authentication success
            txn = Transaction()
            txn.amount = str(req_amount) # floats need to be converted to str first
            txn.institution = institution
            txn.identifier = req_identifier
            txn.save()
			
			# Put fee items in queue
            #Tasks().put_in_queue(req_fees)
			
            options = {}
            for k,v in req_fees.iteritems():
				type = k
				fee = v
				timeout = fee.get(u'timeout')
				options['type'] = type
				options['req_digest'] = req_digest
				
				""" Using timeout value from the fees item is not appropriate and will cause a heavy 
				load on both the message server and hardware itself. Instead countdown here should 
				be set to 3 minutes interval for each transaction.
				
				The timeout value should now be used as a expiry value for each task in the db.
				Such that each record in transaction_tasks table whose status is pending, a new task
				will be executed to expire such items when its timeout period has elapsed.
				"""
				insert_transaction.apply_async([fee, options], countdown=180)
				# if the tasks are successful
				# 

            return HttpResponseCreated(dumps({'status': 'OK', 'tpin': txn.tpin}), mimetype='application/json')
        else:
            #return HttpResponseUnauthorized(dumps({'status': 'ERR', 'message': 'Unauthorized'}), mimetype='application/json')
			#return render_to_response("webapp/test.html", {'auth_digest': auth_digest })
			return HttpResponse("Bad digest %s." % auth_digest)
    except Institution.DoesNotExist:
        # what to do if the institution was not found
        #return HttpResponseUnauthorized(dumps({'status': 'ERR', 'message': 'Unauthorized'}), mimetype='application/json')
		#return render_to_response("webapp/test.html", {'auth_digest': auth_digest })
		return HttpResponse("Institution doesn't exist %s.")

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
    req = dict([[key, params.get(key, '')] for key in ['code', 'identifier', 'amount']]) # add code, identifier and amount to a list
    """Get an institution with the given req[code] i.e university code"""
    institution = Institution.objects.get(code__iexact=req['code'])
    text = ":".join([req[x] for x in ['code', 'identifier', 'amount']] \
        + [institution.secret])
    return md5(text).hexdigest().upper()
	
def _txn_digest_rewrite(params):
	req = dict([[key, params.get(key, '')] for key in ['code', 'identifier', 'amount']]) 
	institution = Institution.objects.get(code__iexact=req['code'])
	text = ":".join(req[x] for x in ['code', 'identifier', 'amount']) + institution.secret
	return md5(text).hexdigest().upper()

	
	
