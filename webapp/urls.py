from django.conf.urls.defaults import *
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
    (r'^$', views.default),
)
