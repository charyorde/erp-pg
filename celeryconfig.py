""" celeryd (Celery worker) looks for a file called celeryconfig.py.

This file is to be renamed to to celeryconfig.py 

"""
import os

import api.tasks as tasks

import djcelery
djcelery.setup_loader()

# Broker settings for celery
BROKER_HOST = "localhost"
BROKER_PORT = 5672
BROKER_USER = "guest"
BROKER_PASSWORD = "guest"
BROKER_VHOST = "/"

#CELERY_IMPORTS = (os.getcwd())

# backend storage
# mysql
CELERY_RESULT_BACKEND = "database"
CELERY_RESULT_DBURI = "mysql://paygw:me2rj@localhost/paygw"

CELERY_SEND_EVENTS = True
CELERY_SEND_TASK_SENT_EVENT = True

# Enables error emails.
CELERY_SEND_TASK_ERROR_EMAILS = True

# Name and email addresses of recipients
ADMINS = (
    ("Kayode Odeyemi", "dreyemi@gmail.com"),
)

# Email address used as sender (From field).
SERVER_EMAIL = "info@opevel.com"

# Mailserver configuration
EMAIL_HOST = "mail.opevel.com"
EMAIL_PORT = 25
# EMAIL_HOST_USER = "servers"
# EMAIL_HOST_PASSWORD = "s3cr3t"