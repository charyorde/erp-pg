from fabric.api import *

def test():
    local('./manage.py test webapp', capture=False)

def deploy():
    test()
    local('git push', capture=False)
    with cd('~/projects/paygw'):
        run('git pull')
        run('touch paygw.wsgi')

