from subprocess import call, check_output
from locale import getpreferredencoding

class TestDjango:
    """ Test if Django and its libraries are properly installed inside venv """
    def django_version(self):
        """ Returns current version of Django """
        output = check_output(['python', '-c', 'import django; print(django.get_version())'])
        return output.decode(getpreferredencoding()).strip()
    
    def test_django_version(self):
        """ Checks that Django is latest stable """
        assert self.django_version() == '1.9.6'