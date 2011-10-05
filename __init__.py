from api.tasks import process_transaction
from webapp.models import TransactionTasks

try:
	queued_tasks = TransactionTasks.objects.filter(status="pending")
	print queued_tasks
except TransactionTasks.DoesNotExist:
	queued_tasks = None 

	# process each transaction at different eta
	try:
		for i in queued_tasks.values():
			if i.get('product_attribute') == u'fees':
			# get its task_id and timeout combination
				task_id = i.get('task_id')
				timeout = i.get('late_registration_date_value')
				type = i.get('product_attribute')
				tpin = i.get('transaction_tpin_fk')
				process_transaction.apply_async([task_id, type, tpin], eta=timeout)
			
			# get its task_id and timeout combination
			if i.get('product_attribute') == u'hostel':
				task_id = i.get('task_id')
				timeout = i.get('hostel_reservation_expiry_date_value')
				type = i.get('product_attribute')
				tpin = i.get('transaction_tpin_fk')
				process_transaction.apply_async([task_id, type], eta=timeout)
	except ValueError:
		print "Invalid task id"