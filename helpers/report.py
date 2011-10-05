__author__="dreyemi@gmail.com"
__date__ ="$Aug 4, 2011 3:47:23 PM$"

import django_tables as tables
from webapp.models import Transaction

class TransactionReport(tables.ModelTable):
    #paid = tables.Column(filter='paid')
    tpin = tables.Column(sortable=False, visible=False)
    identifier = tables.Column(sortable=False, visible=False)
    created = tables.Column(sortable=True, visible=True)

    @classmethod
    def get_reports_paid(self, object, req):
        return TransactionReport(object, order_by=req)

    class Meta:  
        model = Transaction


