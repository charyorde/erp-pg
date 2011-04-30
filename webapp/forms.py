from django import forms
from models import *

class TransactionUpdateForm(forms.ModelForm):
    class Meta:
        model = Transaction
        fields = ('teller_no', 'paid')

class UserCreationForm(forms.Form):
    username = forms.CharField(required=True, label="Username", max_length=30, min_length=3, widget=forms.TextInput(attrs={'autocomplete': 'off','class': 'text_field',}), 
        help_text='The chosen username should be unique and not less than 3 characters or more than 30 characters long',
        error_messages={'required': 'Please supply a username for this teller.',
                        'min_length': 'The chosen username must be at least 3 characters.',
                        'max_length': 'The username should not be more than 30 characters long.'})
    password = forms.CharField(required=True, label="Password", max_length=30, min_length=3, widget=forms.PasswordInput(attrs={'class': 'text_field',}),
        help_text='The password for this account should between 3 and 30 characters in length',
        error_messages={'required': 'A password is required.',
                        'min_length': 'The chosen password must be at least 3 characters.',
                        'max_length': 'The maximum allowed characters for the password is 30.'})
    password_verify = forms.CharField(required=True, label="Retype Password", widget=forms.PasswordInput(attrs={'class': 'text_field',}),
        help_text='Retype your chosen password here.',
        error_messages={'required': 'A value also needs to be supplied in the "Retype Password" field.'})
    first_name = forms.CharField(required=True, label="First Name", widget=forms.TextInput(attrs={'class': 'text_field',}),
        error_messages={'required': 'Please provide a first name for this teller.'})
    last_name = forms.CharField(required=True, label="Lastname", widget=forms.TextInput(attrs={'class': 'text_field',}),
        error_messages={'required': 'Please provide a lastname for this teller.'})
    email = forms.EmailField(required=True, label="Email", widget=forms.TextInput(attrs={'class': 'text_field',}),
        error_messages={'required': 'An email address is required.',
                        'invalid': 'The email address provided is not a valid email address.'})

    def clean_password_verify(self):
        password = self.cleaned_data['password'] if self.cleaned_data.has_key('password') else ''
        password_verify = self.cleaned_data['password_verify'] if self.cleaned_data.has_key('password_verify') else ''
        if not password == password_verify:
            raise forms.ValidationError("Your passwords don't match")

        return password_verify

    def clean_username(self):
        username = self.cleaned_data['username']
        try:
            user = User.objects.get(username=username)
            raise forms.ValidationError("This username has already been used. Please choose another")
        except User.DoesNotExist:
            return username

class UserUpdateForm(forms.Form):
    password = forms.CharField(required=False, label="Password", max_length=30, min_length=3, widget=forms.PasswordInput(attrs={'class': 'text_field',}),
        help_text='To update this teller without changing the password, leave this field blank.',
        error_messages={'required': 'A password is required.',
                        'min_length': 'The chosen password must be at least 3 characters.',
                        'max_length': 'The maximum allowed characters for the password is 30.'})
    password_verify = forms.CharField(required=False, label="Retype Password", widget=forms.PasswordInput(attrs={'class': 'text_field',}),
        help_text='Retype your chosen password here.',
        error_messages={'required': 'A value also needs to be supplied in the "Retype Password" field.'})
    first_name = forms.CharField(required=True, label="First Name", widget=forms.TextInput(attrs={'class': 'text_field',}),
        error_messages={'required': 'Please provide a first name for this teller.'})
    last_name = forms.CharField(required=True, label="Lastname", widget=forms.TextInput(attrs={'class': 'text_field',}),
        error_messages={'required': 'Please provide a lastname for this teller.'})
    email = forms.EmailField(required=True, label="Email", widget=forms.TextInput(attrs={'class': 'text_field',}),
        error_messages={'required': 'An email address is required.',
                        'invalid': 'The email address provided is not a valid email address.'})

    def clean_password_verify(self):
        password = self.cleaned_data['password']
        password_verify = self.cleaned_data['password_verify']
        if not password == password_verify:
            raise forms.ValidationError("Your passwords don't match")

        return password_verify
