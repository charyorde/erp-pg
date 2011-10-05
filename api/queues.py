""" Handle transaction processing using core python
	multiprocessing module
	
	Status: Incomplete
	Use tasks.py instead

"""

import multiprocessing
from multiprocessing import Process
#from multiprocessing import Queue as Queue
from multiprocessing.queues import Queue
from Queue import Empty

class Tasks(object):
    def __init__(self):
        """ no-arg constructor """
        pass
		
    def post_transaction(self):
		""" Called by process(digest) to post data to external
		applications such as EduERP which needs the transaction status."""
		pass
		
    def process(self, **kwargs):
		""" Processes a trasaction item in a queue identified by its digest.
		A new process id is triggered for this item.
		We decided not to use product attribute in order not to
		modify the existing structure of the Transaction model. 
		
		This is called once a transaction is marked as paid
		"""
		#queue = multiprocessing.Queue()
		queue = kwargs['q']
		"""for k,v in kwargs.items():
			q=k[q]
			print k"""
		# Don't start the process if there's no item in queue
		if queue.empty():
			print 'empty queue'
			multiprocessing.Process() # Process defaults to None
			#q.close()
		else:
			p = Process(target=self.transaction_queue, args=(kwargs))
			p.start()
			#print 'process started'
			#p.join(timeout) #wait for one pid to finish before another
			print queue.get()
		
    def update_transaction_queue(self):
		""" Updates transaction_queue table when a transaction item
		is been processed
		
		This is called by process(digest)
		"""
		pass
		
    def put_in_queue(self, items={}):
		""" Put the data sent from external applications such as 
			EduERP in a queue for processing.
			
		Returns the queue
		"""
		
		#items = parse_data(data)
		#print items
		global queue
		queue = multiprocessing.Queue()
		
		try:
			# For each items identified by its product attribute, set its timeout
			for k,v in items.iteritems():
				data = v #data is a dict
				#sort the data
					
				# get timeout
				#timeout = items.get(i)
				#timeout = data[1][1]
				timeout = data.get(u'timeout')
				
				# Put the transaction item in the queue at a specific timeout
				# period
				#x = queue.put(data, False, timeout)
				#print "{0} put to queue".format(x)
				self.transaction_queue(queue, data, timeout)
				#break
		except (KeyError, AttributeError, ValueError):
			print 'Incorrect data format'
		
    def transaction_queue(self, queue, item, timeout, block=False):
		#queue = put_in_queue.__getattribute__(q)
		#print queue
		d = {}
		#queue = multiprocessing.Queue()
		"""try:
			timeout
		except NameError:
			timeout = args[1]"""
			#pass
		if item != {} and timeout != None:
			#print "Items are {0}".format(item)
			x = queue.put(item, block, timeout)
			print "{0} put to queue".format(x)
			#for f in range(len(item)):
			"""try:
				if isinstance(queue, Queue):
					d = queue.get(block)
					#print d
			except Empty:
				#print 'Fees queue empty at %s' % (f)
				pass
			else:
				#return self.process(q=queue, i=d, t=timeout)
				pass"""
		else:
			print 'No item in queue to get'

    def parse_data(self, data):
		""" Parses data sent from external application such as
		EduERP
		"""
		try:
			for k,v in data.iteritems():
				values = v
		except KeyError:
			print 'incorrect data format'
		