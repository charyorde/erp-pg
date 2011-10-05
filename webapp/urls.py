from django.conf.urls.defaults import *
from views import TransactionResourceRoot
from views import TransactionResource
import views

urlpatterns = patterns('',
    url(r'^login/?$', 'django.contrib.auth.views.login', {'template_name': 'webapp/login.html'}, name="login"),
    url(r'^logout/?$', 'django.contrib.auth.views.logout_then_login', name="logout"),
    url(r'^update/(?P<tpin>.+)/?$', views.update_transaction, name="update-txn"),
    url(r'^search/?$', views.search_transaction, name="search-txn"),
    url(r'^user/list/?$', views.list_users, name="list-users"),
    url(r'^user/add/?$', views.add_user, name="add-user"),
    url(r'^user/delete/?$', views.delete_user, name="delete-user"),
    url(r'^user/update/(?P<user_id>\d+)/?$', views.update_user, name="update-user"),
    #url(r'^$',                 TransactionResourceRoot.as_view(), name='transaction-resource'),
    url(r'^service/transaction/add/$', TransactionResource.as_view(), name='put-transaction'),
    url(r'^reports/(?P<page>)/?$', views.display_reports, name="display-reports"),
    url(r'^reports/csv/(?P<page>)?$', views.print_to_csv, name="print-to-csv"),
    (r'^$', views.default),
    #url(r'^api/transaction/add', views.put_transaction, name="put-transaction")
)

