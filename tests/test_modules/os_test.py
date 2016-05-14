from subprocess import call, check_output
from locale import getpreferredencoding

class TestOs:
    """ Contains test methods to test 
    if the vagrant OS got installed properly """
    
    def uname_kernel(self):
        """ returns output of uname -s """
        output = check_output(['uname', '-s']).decode(getpreferredencoding()).strip()
        return output
    
    def uname_os(self):
        """ returns the output of uname -o """
        output = check_output(['uname', '-o']).decode(getpreferredencoding()).strip()
        return output
    
    def test_uname_kernel(self):
        """ tests the output of uname_kernel() """
        assert self.uname_kernel() == 'Linux'
    
    def test_uname_os(self):
        """ tests the output of uname_os() """
        assert self.uname_os() == 'GNU/Linux'

