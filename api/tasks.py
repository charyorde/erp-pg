""" Handle transaction processing using celery - a
	distributed task queue system

package: api.tasks
	
"""

import urllib2
import urllib

from celery.task import task
from celery.task import Task
#from celery.decorators import task
#from celery.registry import tasks
from webapp.models import Transaction, TransactionTasks
from edupay.api import db

# constant
EdupayUrl = 'http://eduerp/service/fees/uid/invoice/regenerate'

# instance of TransactionTasks
task_model = TransactionTasks()
	
class PostTransaction(Task):
    name = "transaction.post"
    #autoregister = True
	
    def __init__(self):
        dir(self)
        pass
	
	def run(self, data):
		dir(self)
		#self.autoregister = True
		return data.__str__()
		
class DebugTask(Task):
	""" Register task manually """
	abstract = True
	
@task(base=DebugTask)
def debug_task():
	dir(task)
	return "task is manually registered"
		
def put_transaction_queue():
	""" Insert records into transaction_queue table
	Records include:
	
	- Ubercart_status
	- product_attribute
	- late_registration_date_value
	- hostel_reservation_expiration_date_value
	- digest (The digest value from Transaction model)
	"""

def register_tasks(cls):
	return ".".join([cls.__module__,
                     cls.__name__])

@task	
def post_transaction_status(request, task_name):
	""" Called when a teller marks a transaction as paid.
	It posts data to external
	applications such as EduERP which needs the transaction status.
	
	"""
		
	# make fees status update POST request to EduERP
	# use http://eduerp/service/fees/uid/status or http://eduerp/service/fees/uid/status/paid or http://eduerp/service/fees/uid/paid
	# post data are uid=uid&service=status&status=payment_received
	# Note: Move this to post_transaction function
	#edupay_request('http://eduerp/service/fees/uid/paid', None, 'POST', )
	pass
	
@task
def insert_transaction(items, options):
	""" Inserts fees items as db records 
	foreach items, insert the records into transaction_tasks table
	"""
	txlist = [items, options]
	
	#for i in txlist:
	txdict_opt = txlist[0]
	txdict_items = txlist[1]
	if txdict_items.get('type') == u'fees':
		task_model.product_attribute = txdict_items.get('type')
		task_model.late_registration_date_value = txdict_opt.get(u'timeout')
		task_model.transaction_tpin_fk = txdict_items.get(u'req_digest')
		task_model.status = txdict_opt.get(u'status')
		task_model.task_status = unicode("in-queue")
		task_model.save()
		
	if txdict_items.get('type') == u'hostel':
		task_model.product_attribute = txdict_items.get(u'type')
		task_model.hostel_reservation_expiry_date_value = txdict_opt.get(u'timeout')
		task_model.transaction_tpin_fk = txdict_items.get(u'req_digest')
		task_model.status = txdict_opt.get(u'status')
		task_model.task_status = unicode("in-queue")
		task_model.save()
	
	#return "The items sent are {0}, {1}".format(items, options)
	return "Transaction successful"

@task
def process_transaction(task, type, tpin):
	"""
	- set the status of the task_status field in transaction_task table to "expired"
	- set the status of the status field in transaction_task table to "not paid"
	- log the status change of this transaction
	- set Transaction model paid field to "not paid"
	- log the status change of the Transaction model paid field 
	- After setting it to "not paid", remove it (We are removing it so that teller won't be able to update it since it is has expired)
	- Log the removal
	- invalidate the invoice of this transaction in EduERP
	- send an email to the user that his/her transaction did not go through because the 
	system hasn't received the fees between so-so period. You will need to process the fee payment again or consult the bursary.
	
	Note: If you expire a task, remove it from the db. When a task is expired in celery, its task_id is erased
	
	:todo use celery task_id to identify tasks
	"""
	
	if type != None:
		# update task_model, set task_status field to "expired" where product_attribute = type
		TransactionTasks.objects.filter(product_attribute__exact=type).update(task_status="expired")
		
		# set the status of the status field in transaction_task table to "not paid"
		TransactionTasks.objects.filter(product_attribute__exact=type).update(status="not paid")
		# :todo log the status change of the Transaction model paid field 
	else:
		raise AttributeError("process_transaction: The product attribute is of wrong type")
	
	#set Transaction model paid field to "not paid"
	if tpin != None:
		Transaction.objects.filter(tpin__exact=tpin).update(paid=0)
		#log this task
		return "Marking {tpin} as unpaid after ... days of non payment".format(tpin)
		
	# :todo log the status change of the Transaction model paid field 
	
	# After setting it to "not paid", remove the transaction from the Transaction model
	"""
	When Django deletes an object, by default it emulates the behavior of the SQL constraint
	ON DELETE CASCADE -- in other words, any objects which had foreign keys pointing at the 
	object to be deleted will be deleted along with it.
	
	This will also delete the transaction_tpin_fk field reference in TransactionTasks
	model.
	"""
	Transaction.objects.filter(tpin__exact=tpin).delete()
	
	# :todo log the removal
	
	#invalidate the invoice of this transaction in EduERP
	# make EduERP POST request. 
	#post data are uid=user_id&service=regenerate&status=unpaid&tpin=tpin;
	# url is use http://eduerp/service/fees/uid/invoice
	# unpaid status is synonymous to Ubercart canceled status
	try:
		user_id = db.edupay_get_user(tpin)
	except AttributeError:
		# return a json response about this failure
		print 'process_transaction: This transaction has an anonymous user'
		raise
		
	#data = "uid=user_id&service=regenerate&type=type&status=unpaid&tpin=tpin"
	data = {"uid":user_id, "service":"regenerate", "type":type, "status":"unpaid", "tpin":tpin}
	edupay_request_python(EduPayUrl, None, 'POST', urlencode(data))
	
		
	return task

def edupay_request_python(url, headers = {}, method = 'GET', data = None, retry = 3):
	req = urllib2.Request(url)
	#req.add_data('status=paid')
	if method == "POST":
		req.add_data(data)
	f = urllib2.urlopen(req)
	f.read()
	
def edupay_request_django(url, headers = {}, method = 'GET', data = None, retry = 3):
	pass
	
def update_transaction_queue():
	""" Updates TransactionTasks model when a transaction item
	is being processed
	
	:see process_transaction
	"""
	
	
	pass
	
@task
def add(x, y):
    return x + y
	
@task(name="tasks.subs")
def subs(x, y):
    return x - y
