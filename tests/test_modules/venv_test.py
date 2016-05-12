from subprocess import call, check_output
from locale import getpreferredencoding
import sys

class TestVenv:
    """ Test that virtualenvwrapper is installed
        a venv with Python 3 is ready"""

    def python_version(self):
        """ return version of python as obtained from python --version """
        output = check_output(['python', '--version']).decode(getpreferredencoding()).strip()
        return output
    
    def test_python_version(self):
        """ test if python is indeed 3.4.3 """
        assert self.python_version() == 'Python 3.4.3'
    
    def test_venv_activated(self):
        """ Test if the Python 3 environment is activated """
        assert hasattr(sys, 'real_prefix')
        
    