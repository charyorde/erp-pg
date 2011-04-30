from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from audit_log.models.managers import AuditLog
from helpers.fields import UUIDField

# Create your models here.
class Institution(models.Model):
    """An institution stores details for institutions"""
    name = models.CharField(max_length=100, blank=False)
    code = models.CharField(max_length=32, blank=True, unique=True)
    secret = UUIDField(max_length=32, editable=False)
    
    def __unicode__(self):
        return self.name
    
class Transaction(models.Model):
    """Gateway transactions"""
    tpin = UUIDField(max_length=32, blank=True, editable=False,\
        help_text='Transaction Payment Identification Number')
    amount = models.DecimalField(max_digits=14, decimal_places=2, \
        help_text='Transaction amount')
    identifier = models.CharField(max_length=100, blank=True, \
        help_text='A unique identifier provided by the student')
    institution = models.ForeignKey(Institution, related_name='transactions')
    paid = models.BooleanField(default=False)
    teller_no = models.CharField(max_length=20, blank=True)
    financial_institution = models.ForeignKey('FinancialInstitution', blank=True, null=True, help_text='The financial institution this transaction was updated in')
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    
    audit_log = AuditLog(exclude=['created', 'updated', ])

    def __unicode__(self):
        return self.tpin

class FinancialInstitution(models.Model):
    name = models.CharField(max_length=100)

    def __unicode__(self):
        return self.name

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
