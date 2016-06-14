from subprocess import call, check_output
from locale import getpreferredencoding

class TestPsql:
    """ Test that PostgreSQL is properly installed, up and running """
    def checkPresence(self):
        output = check_output(['psql','--version']).decode(getpreferredencoding()).strip()
        print(output)
        return output

    def checkDatabase(self):
        output = check_output(['psql', '-dfcc_provision', '-c select datname from pg_database']).decode(getpreferredencoding()).strip()
        return output

    def testPsqlConnection(self):
        """ Test the connection of psql """
        assert self.checkPresence().index('psql') >= 0

    def testPsqlDatabase(self):
        """ Test the presence of database """
        assert self.checkDatabase().index('fcc_provision') >= 0
