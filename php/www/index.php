<!doctype html>

<html lang="en">
	<head>
		<meta charset="utf-8">

		<title>Zeus PHP</title>
		<meta name="author" content="FreeCodeCamp team">

		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">
		<style>
			body{
				color:#444;
			}
			.sectionHeader{
				margin:0px -11px;
				text-align: center;
				padding:50px;
			}
			.card-panel{
				padding:5px 15px;
			}
			code {
				background-color:#CFC;
				padding:2px 5px;
				border-radius:3px;
				font-size:0.9em;
			}
			h2{
				font-size:1.8em;
			}
			h3{
				font-size:1.5em;
			}
			ul{
				list-style-type:circle;
			}
			li{
				margin-left:15px;
				padding-left:15px;
			}
			#phpinfo {font-size:0.8em;}
			#phpinfo pre {}
			#phpinfo a:link {}
			#phpinfo a:hover {}
			#phpinfo table {
				width: 100%;
				max-width: 100%;
				display: table;
			}
			#phpinfo table > thead > tr {
				border-bottom: 1px solid #d0d0d0;
			}
			#phpinfo table > thead > tr,
			#phpinfo table > tbody > tr {
				border-bottom: 1px solid #d0d0d0;
			}

			#phpinfo table > tbody > tr:nth-child(odd) {
				background-color: #f2f2f2;
			}
			#phpinfo table > tbody > tr > td {
				border-radius: 0;
				padding:5px;
			}
			#phpinfo .center {text-align: center}
			#phpinfo .center table {text-align: center}
			#phpinfo .center th {text-align: center}
			#phpinfo th {font-weight: bold; font-size:1.2em}
			#phpinfo h1 {font-size:2em}
			#phpinfo h2 {}
			#phpinfo .p {}
			#phpinfo .e {}
			#phpinfo .h {}
			#phpinfo .v {word-wrap:break-all;}
			#phpinfo .vr {}
			#phpinfo img {}
			#phpinfo hr {}
		</style>
		<!--[if lt IE 9]>
			<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
	</head>

	<body>
		<div class="navbar-fixed">
			<nav>
				<div class="nav-wrapper green">
					<div class="container">
						<a href="#!" class="brand-logo">Zeus for PHP</a>
					</div>
				</div>
			</nav>
		</div>
		<div class="container-fluid">
			<div class="row">
				<div class="col s12">
					<div class="sectionHeader green lighten-1">
						<h1>It works !</h1>
						<p>You are seeing this because the Zeus for PHP box is up and working</p>
					</div>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="col s12">
					<h2>What now ?</h2>
					<p>This this file is located in the <code>/vagrant/www</code> directory on the <em>guest box</em>, wich is your base of work for your PHP files.</p>
					<p>The <code>/vagrant/www</code> folder is a shared folder, so you will find its content on the <em>hosting</em> machine in the <code>&lt;path-to-your-zeus-php-project&gt;/www</code> folder.</p>
					<p>
						Happy coding !
						<br/>
						<em>The FreeCodeCamp development team.</em>
					</p>
				</div>
			</div>
			<div class="row">
				<div class="col s12">
					<div class="row">
						<div class="col s6">
							<h2>Packages</h2>
							<p>
								This virtual machine has been created with the following php extensions:
							</p>
							<pre>
php5 
php5-cli
php5-pgsql 
php5-sqlite 
php5-intl 
php5-mcrypt 
php5-apcu 
php5-gd
phpunit 
</pre>
							<p>PostgreSQL is the database server: </p>
							<pre>
postgresql
postgresql-contrib 
</pre>
							<p>Of course, <code>git</code> and the <code>heroku-toolelt</code> are present too.</p>
							<a class="btn waves-effect waves-light modal-trigger" href="#phpinfo">Display complete phpinfo</a>
						</div>
						<div class="col s6">
							<h2>Database configuration</h2>
							<h3>Local</h3>
							<p>
								This machine is setup with two postgrSQL databases: <code>my_app</code>, and <code>my_app_test</code>.
								The last one is meant to be used if you run phpunit tests against your code.<br/>
								The default configuration to access your databases are:
							</p>
							<pre>
host: localhost
db name : my_app (or my_app_test)
user: vagrant
password: vagrant
</pre>

							<h3>Local connection test</h3>
							<?php
							// Use the DATABASE_URL environment variable
							$db = parse_url(getenv('DATABASE_URL'));

							// Then, access the properties like this:
							$host = $db['host'];
							$username = $db['user'];
							$password = $db['pass'];
							$database = ltrim($db["path"], '/');
							$connection = pg_connect("host=$host port=5432 dbname=$database user=$username password=$password");
							$class = 'green white-text';
							$message = 'PHP is able to connect to the database';
							if ($connection === false) {
								$class = 'red white-text';
								$message = 'PHP was unable to connect to the database';
							}
							pg_close($connection);
							?>
							<div class='card-panel <?php echo $class ?>'><?php echo $message ?></div>

							<h3>Heroku</h3>
							<p>
								To use a postgreSQL database on Heroku, you will need the Heroku-Postgres addon. You can enable it using the toolbelt with this command:<br/>
								<code>heroku addons:create heroku-postgresql:hobby-dev</code>
							</p>
							<p>
								Heroku uses environment variables, so when you want to deploy your application on it, you have to use this configuration:
							</p>
							<pre>
// Use the DATABASE_URL environment variable
$db = parse_url(getenv('DATABASE_URL'));

// Then, access the properties like this:
$host =     $db['host'];
$username = $db['user'];
$password = $db['pass'];
$database = ltrim($db["path"],'/');
</pre>
							<p>For your comfort, the same environment variable has been setup for the database <code>my_app</code>. That way, you don't have to bother on the differences of configuration between this virtual machine and heroku.
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="phpinfo" class="modal bottom-sheet">
			<div class="modal-content">
				<h4>PHP info</h4>
				<?php
				ob_start();
				phpinfo();
				$pinfo = ob_get_contents();
				ob_end_clean();

				$pinfo = preg_replace('%^.*<body>(.*)</body>.*$%ms', '$1', $pinfo);
				echo $pinfo;
				?>
			</div>
			<div class="modal-footer">
				<a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Ok</a>
			</div>
		</div>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
		<script>
			$(document).ready(function () {
				// the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
				$('.modal-trigger').leanModal();
			});
		</script>
	</body>
</html>