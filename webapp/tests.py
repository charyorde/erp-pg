from django.test import TestCase
from models import Institution, Transaction
from api.views import _txn_digest
from django.test.client import Client
from simplejson import loads

class ApiTest(TestCase):
    def setUp(self):
        self.institution = Institution.objects.create(name="Uni for Dummies", code="12345")
        self.txn = Transaction.objects.create(amount='10000.50',institution=self.institution,identifier='2',\
            paid=True,teller_no='22222')
        self.c = Client()

    def testAddTransaction(self):
        params = {'code': '12345', 'amount': '10000.50', 'identifier': '1', }
        digest = _txn_digest(params)
        params['digest'] = digest

        response = self.c.post('/api/transaction/add', params)
        # test if it was created
        self.assertEqual(response.status_code, 201)
        
        json_response = loads(response.content)
        # did we get the OK status response?
        self.assertEqual(json_response.get('status'), 'OK')

        txn = Transaction.objects.get(identifier__iexact='1')
        self.assertEqual(json_response.get('tpin'), txn.tpin)
        self.assertEqual(float(txn.amount), 10000.50)

    def testViewTransaction(self):
        # Test viewing transactions
        params = {'code': '12345'}
        response = self.c.post('/api/transaction/view/' + self.txn.tpin, params)
        self.assertEqual(response.status_code, 200)

        json_response = loads(response.content)
        # check for OK status
        self.assertEqual(json_response.get('status'), 'OK')
        self.assertEqual(json_response.get('tpin'), self.txn.tpin)
        self.assertEqual(json_response.get('identifier'), '2')
        self.assertEqual(float(json_response.get('amount')), 10000.50)
        self.assertEqual(json_response.get('paid'), True)
        self.assertEqual(json_response.get('teller_no'), '22222')

