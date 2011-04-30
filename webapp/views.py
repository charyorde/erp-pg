from django.shortcuts import render_to_response, get_object_or_404
from django.core.urlresolvers import reverse
from django.db.models import Q
from django.http import HttpResponseRedirect
from django.contrib.auth.decorators import login_required, permission_required
from django.contrib.auth.models import User
from django.template import RequestContext as RC
from forms import TransactionUpdateForm, UserCreationForm, UserUpdateForm
from models import Transaction

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

