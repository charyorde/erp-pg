from django.conf.urls.defaults import *
import views

urlpatterns = patterns('',
    (r'transaction/add', views.add_transaction),
    (r'transaction/view/(?P<tpin>.+)', views.view_transaction),
)
