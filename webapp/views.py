import csv
from django.shortcuts import render_to_response, get_object_or_404
from django.core.urlresolvers import reverse
from django.db.models import Q
from django.http import HttpResponseRedirect
from django.contrib.auth.decorators import login_required, permission_required
from django.contrib.auth.models import User
from django.template import RequestContext as RC
from forms import TransactionUpdateForm, UserCreationForm, UserUpdateForm
#from django.tests.modeltests.reserved_names.models import join
from models import Transaction

import logging

from djangorestframework.resource import Resource
from djangorestframework.response import Response

import django_tables as tables
from helpers.report import TransactionReport
from django.http import HttpResponseNotFound, HttpResponse
from django.template import loader, Context
from django.core import serializers
from django.forms.models import model_to_dict
from django.core.paginator import Paginator, InvalidPage, EmptyPage
import sys

@login_required
def default(request):
    return search_transaction(request)

@login_required
def search_transaction(request):
    context = {'page_title': 'Search Transaction'}
    if request.POST:
        identifier = request.POST.get('identifier', None)
        try:
            qs = Q(financial_institution=None) | Q(financial_institution=request.user.get_profile().financial_institution)
            txn = Transaction.objects.filter(qs).get(identifier=identifier)
            return HttpResponseRedirect(reverse('update-txn', args=[txn.tpin]))
        except Transaction.DoesNotExist:
            request.flash.now['error'] = "Transaction not found"
    return render_to_response("webapp/search_transaction.html", context, context_instance=RC(request))


@login_required
def update_transaction(request, tpin=None):
    qs = Q(financial_institution=None) | Q(financial_institution=request.user.get_profile().financial_institution)
    txn = get_object_or_404(Transaction.objects.filter(qs), tpin=tpin) 
    context = {'page_title': 'Update Transactions'}
    if request.POST:
        update_form = TransactionUpdateForm(request.POST, instance=txn)
        if update_form.is_valid():
            update_form.save()

            # update the financial institution of the transaction to that of the editor
            txn.financial_institution = request.user.get_profile().financial_institution
            txn.save()

            # attached a success message to the flash
            request.flash.now['notice'] = "Transaction updated."
            return HttpResponseRedirect(reverse('search-txn'))
        else:
            # form is invalid
            print update_form.errors
            request.flash.now['error'] = "The update wasn't made due to some errors in the form"
    else:
        update_form = TransactionUpdateForm(instance=txn)
    context['txn'] = txn
    context['form'] = update_form
    return render_to_response("webapp/update_transaction.html", context, context_instance=RC(request))

@permission_required('auth.change_user')
@login_required
def list_users(request):
    user_list = User.objects.filter(userprofile__supervisor=request.user)
    return render_to_response("webapp/list_users.html", {'user_list': user_list }, context_instance=RC(request))

@permission_required('auth.change_user')
@login_required
def add_user(request):
    if request.POST:
        user_form = UserCreationForm(request.POST)
        if user_form.is_valid():
            # create the user and update profile information
            user = User.objects.create_user(user_form.cleaned_data['username'], user_form.cleaned_data['email'], user_form.cleaned_data['password'])
            user.first_name = user_form.cleaned_data['first_name']
            user.last_name = user_form.cleaned_data['last_name']
            user.save()
            profile = user.get_profile()
            profile.supervisor = request.user
            profile.financial_institution = request.user.get_profile().financial_institution
            profile.save()

            request.flash.now['notice'] = "Teller successfully created!"
            user_form = UserCreationForm()
        else:
            errors_list = [user_form.errors[key] for key in user_form.errors.keys()]
            error_messages = ["<br />".join(x) for x in errors_list]
            error_messages = "<br />".join(error_messages)
            request.flash.now['error'] = error_messages
    else:
        user_form = UserCreationForm()

    return render_to_response("webapp/add_user.html", {'form': user_form }, context_instance=RC(request))
            
@permission_required('auth.change_user')
@login_required
def update_user(request, user_id=None):
    user = get_object_or_404(User, userprofile__supervisor=request.user, pk=user_id) 
    if request.POST:
        user_form = UserUpdateForm(request.POST)
        if user_form.is_valid():
            # create the user and update profile information
            user.first_name = user_form.cleaned_data['first_name']
            user.last_name = user_form.cleaned_data['last_name']
            user.email = user_form.cleaned_data['email']
            if user_form.cleaned_data['password']:
                user.set_password(user_form.cleaned_data['password'])
            user.save()

            request.flash.now['notice'] = "Teller successfully updated!"
            user_form = UserUpdateForm()
        else:
            errors_list = [user_form.errors[key] for key in user_form.errors.keys()]
            error_messages = ["<br />".join(x) for x in errors_list]
            error_messages = "<br />".join(error_messages)
            request.flash.now['error'] = error_messages
    else:
        user_form = UserUpdateForm()
    context = {'form': user_form }
    context['user'] = user

    return render_to_response("webapp/update_user.html", context, context_instance=RC(request))

@permission_required('auth.change_user')
@login_required
def delete_user(request):
    if request.POST:
        user_ids = request.POST.getlist('id')
        for user_id in user_ids:
            if user_id.isdigit():
                try:
                    u = User.objects.get(pk=int(user_id),userprofile__supervisor=request.user)
                    u.delete()
                except:
                    pass
    return HttpResponseRedirect(reverse('list-users'))

def put_transaction(request):
    # Get an instance of a logger
    logger = logging.getLogger(__name__)
    logger.info("Called put_transaction")
    #return


class TransactionResourceRoot(Resource):
    allowed_methods = anon_allowed_methods = ('GET')

    def get(self, request, auth):
        return [reverse('put-transaction')]
    
class TransactionResource(Resource):
    """Represents a stored object.
    The object may be any picklable content."""
    allowed_methods = anon_allowed_methods = ('GET', 'PUT', 'POST')

    def get(self, request, content):
        return "GET request"
    
    def post(self, request, auth, content):
        """Handle POST requests"""
        logger = logging.getLogger(__name__)
        logger.info("Called put_transaction")
        return "POST request to StoredObject"

    """
    def get(self, request, auth, key):
        Return a stored object, by unpickling the contents of a locally stored file.
        pathname = os.path.join(OBJECT_STORE_DIR, key)
        if not os.path.exists(pathname):
            return Response(status.HTTP_404_NOT_FOUND)
        return pickle.load(open(pathname, 'rb'))

    def put(self, request, auth, content, key):
        Update/create a stored object, by pickling the request content to a locally stored file.
        pathname = os.path.join(OBJECT_STORE_DIR, key)
        pickle.dump(content, open(pathname, 'wb'))
        return content

        """

@login_required
def display_reports(request, **kwargs):
    #data = Transaction.objects.all()
    logger = logging.getLogger(__name__)
    try:
        dataqs = Transaction.objects.filter(paid="TRUE")
    except Transaction.DoesNotExist:
        dataqs = None
    #req = request.GET.get('sort', 'created')
    #transactions = TransactionReport(dataqs, order_by=request.GET.get('sort', 'created'))
    #tx = TransactionReport().get_reports_paid(dataqs, req)
    SHOW_CONTENT_LIMIT = 2
    paginate_list = Paginator(dataqs, SHOW_CONTENT_LIMIT)
    start_req_page = request.GET.get(u'page', 1).__str__() #converts start_req_page to string
    if start_req_page.isdigit():
        page_no = int(request.GET.get(u'page', 1))
    else:
        print u'The variable String contains no digit'
    try:
        contents = paginate_list.page(page_no)
    except (EmptyPage, InvalidPage):
        contents = paginate_list.page(paginate_list.num_pages)
    total_pages_list = range(1,  paginate_list.num_pages + 1)# a list of arithmetic progressions e.g 1,2...
    #print dir(contents) #dir is similar to print_r
    #print dir(contents.object_list)
    #print dir(contents.object_list.model)

    x = {contents.number:contents.object_list}

    request.session['contents'] = x

    #page_session_data = request.session['contents']
    #print request.session['contents']
    
    #return render_to_response('webapp/reports.html', {'table': transactions})
    return render_to_response('webapp/reports.html', {'table': dataqs, 'contents':contents,'total_pages_list':total_pages_list}, context_instance=RC(request))

    #return HttpResponse(tx)



# call report_to_csv. url = report/csv
def print_to_csv(request, **kwargs):
    response = HttpResponse(mimetype='text/csv')
    response['Content-Disposition'] = 'attachment; filename=report_csv.csv'

    #response = HttpResponse(pickle.dumps(entry_list),mimetype='application/x-pickle.python')
    
    #params.get('contents')
    page = int(request.GET.get('page'))
    #print request
    #print request.session['contents']
    print request.session['contents'][page]

    #data = this context.__getattr__.display_report or TransactionReport.__getattr__(get_report_paid)
   # data = display_reports().object.tx.get_context_data(**kwargs)
    #data = TransactionReport.get_reports_paid(Transaction.objects.filter(paid="TRUE"), request)
    #data = Transaction.objects.all()[:2]
    #print request.GET.
    #data = Transaction.objects.all()
    data = request.session['contents'][page]
    print dir(data.values())
    #data = request.get_context_data(**kwargs)
    #data = Transaction.objects.order_by('created')[0]
    #serialized = serializers.serialize(u'python', data, use_natural_keys=True )
    serialized = serializers.serialize('csv', data.values() )

    rows = [item["fields"] for item in serialized]
    fieldnames = rows[0].keys()
    writer = csv.DictWriter(sys.stdout, fieldnames)
    writer.writeheader()
    writer.writerows(rows)

    return response
