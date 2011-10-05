""" App daos """

from webapp.models import Transaction

def edupay_get_user(tpin):
	""" Get user by transaction pin """
	try:
		uid = Transactions.objects.filter(tpin__exact=tpin).values('user_id')
	except TransactionTasks.DoesNotExist:
		raise AttributeError('Invalid transaction')