from subprocess import call, check_output

class TestPsql:
    """ Test that PostgreSQL is properly installed, up and running """
    def checkPresence(self):
        output = check_output(["psql","--version"]).decode("utf-8").lstrip().rstrip()
        print(output)
        return output

    def checkDatabase(self):
        output = check_output(["psql", "-dfcc_provision", "-c select datname from pg_database"]).decode("utf-8").lstrip().rstrip()
        return output

    def testPsqlConnection(self):
        """ Test the connection of psql """
        assert self.checkPresence().index('psql') >= 0

    def testPsqlDatabase(self):
        """ Test the presence of database """
        assert self.checkDatabase().index('fcc_provision') >= 0
