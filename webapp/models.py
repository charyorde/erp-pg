from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from audit_log.models.managers import AuditLog
from helpers.fields import UUIDField


""" a tuple of branch code as key and branch name as value """
FINANCIAL_INSTITUTION_BRANCHES = (
    ('BR_CODE1', 'Headquarters, Danmole Street VI'),
    ('BR_CODE2', 'Usman Dan Fodio University Branch'),
)
    
# Create your models here.
class Institution(models.Model):
    """An institution stores details for institutions"""
    name = models.CharField(max_length=100, blank=False)
    code = models.CharField(max_length=32, blank=True, unique=True)
    secret = UUIDField(max_length=32, editable=False)
    
    def __unicode__(self):
        return self.name

class Branch(models.Model):
    """ Branch """
    bid = models.AutoField(primary_key=True)
    institution = models.CharField(max_length=50)
    branchcode = models.CharField(max_length=50)
    name_branch = models.CharField(max_length=50)
    name_branch_short = models.CharField(max_length=50)
    address_1 = models.CharField(max_length=100)
    name_city = models.CharField(max_length=50)
    name_state = models.CharField(max_length=50)
    sector = models.CharField(max_length=50)

    class Meta:
        db_table = u'branch'

    def __unicode__(self):
        return u"%s | %s" % (
            unicode(self.name_branch),
            unicode(self.address_1))

class Transaction(models.Model):
    """Gateway transactions"""
    id = models.AutoField(primary_key=True)
    tpin = UUIDField(max_length=32, blank=True, editable=False,\
        help_text='Transaction Payment Identification Number')
    user_id = models.IntegerField(help_text='The user who made the transaction')
    amount = models.DecimalField(max_digits=14, decimal_places=2, \
        help_text='Transaction amount')
    identifier = models.CharField(max_length=100, blank=True, \
        help_text='A unique identifier provided by the student')
    institution = models.ForeignKey(Institution, related_name='transactions')
    financial_institution = models.ForeignKey('FinancialInstitution', blank=True, null=True, related_name='transactions', help_text='The financial institution this transaction was updated in')
    branch_name = models.ForeignKey(Branch, blank=True, null=True, related_name='transactions', \
        help_text='The bank branch where this transaction is originating from')
    #branch_name_id = models.IntegerField(null=True, blank=True)
    paid = models.BooleanField(default=False)
    teller_no = models.CharField(max_length=20, blank=True)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    
    audit_log = AuditLog(exclude=['created', 'updated', ])

    def __unicode__(self):
        return self.tpin

    """def natural_key(self):
        return self.tpin"""

class TransactionTasks(models.Model):
    task_id = models.IntegerField(primary_key=True)
    product_attribute = models.CharField(max_length=30)
    late_registration_date_value = models.IntegerField(null=True, blank=True)
    hostel_reservation_expiry_date_value = models.IntegerField(null=True, blank=True)
    #transaction_tpin_fk = models.CharField(max_length=96) #Should be made a unique field in the db
    transaction_tpin_fk = models.ForeignKey(Transaction, related_name='transactions')
    status = models.CharField(max_length=30)
    task_status = models.CharField(max_length=30)
    class Meta:
        db_table = u'transaction_tasks'
				
class FinancialInstitution(models.Model):
    name = models.CharField(max_length=100)
    #field = 'name_branch'
    #BRANCHES = Branch.objects.values_list('branchcode', field)
    #branch_name = models.CharField(max_length=50,unique=True, choices=BRANCHES)
    #branch_name = models.CharField(max_length=100,unique=True)

    def __unicode__(self):
        return self.name
        """return u"%s | %s" % (
            unicode(self.name),
            unicode(self.branch_name))"""

    @staticmethod
    def get_branches(self, field):
        return Branch.objects.values_list(field, flat=True)


class UserProfile(models.Model):
    """User Profile"""
    user = models.OneToOneField(User)
    supervisor = models.ForeignKey(User, related_name='bank_tellers', null=True, blank=True)
    financial_institution = models.ForeignKey('FinancialInstitution', null=True, blank=True, help_text='The finanacial institution this user belongs to')
    
    def __unicode__(self):
        return self.user.username
        
def user_handler(sender, **kwargs):
    """signal processor for creating a UserProfile for every User"""
    if kwargs['created']:
        profile = UserProfile()
        profile.user = kwargs['instance']
        profile.save()

post_save.connect(user_handler, sender=User)
