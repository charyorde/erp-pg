import os, sys
import django.core.handlers.wsgi

#path = 'c:/wamp/www/edupay/'
#if path not in sys.path:
    #sys.path.append(path)

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

os.environ['DJANGO_SETTINGS_MODULE'] = 'settings'
os.environ["CELERY_LOADER"] = "django"

application = django.core.handlers.wsgi.WSGIHandler()