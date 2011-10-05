from django.db import models
#from uuid import get_hex
from uuid import uuid4

class UUIDField(models.CharField):
    def __init__(self, *args, **kwargs):
        kwargs['max_length'] = kwargs.get('max_length', 32)
        kwargs['blank'] = True
        models.CharField.__init__(self, *args, **kwargs)

    def pre_save(self, model_instance, add):
        if add:
            value = uuid4().get_hex()
            #value = "010485".join(get_hex());
            #value = md5("010485")
            # assigns the uuid4 value to the UUIDField. This is similar to saying model_instance.self.attname = value
            setattr(model_instance, self.attname, value) 
            return value
        else:
            return super(models.CharField, self).pre_save(model_instance, add)
