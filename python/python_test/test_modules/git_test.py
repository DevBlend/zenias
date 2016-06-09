from subprocess import call, check_output
from locale import getpreferredencoding

class TestGit:
    """ Test that the user has a modern version of git installed """
    
    def git_version(self):
        """ returns a tuple with execution of git --version """
        exit_code = call(['git', '--version'])
        output = check_output(['git', '--version']).decode(getpreferredencoding()).strip()
        return (output, exit_code)
    
    def test_git_version(self):
        """ tests the output from git_version() """
        assert self.git_version()[1] == 0
        assert self.git_version()[0].index('git version') >= 0