# Zeus for PHP

## Filesystem
 The document root of the Apache sercer is located in the `/vagrant/www` directory on the _guest box_, wich is your base of work for your PHP files.

This `/vagrant/www` folder is a shared folder: so you will find its content on the _hosting_ machine in the `<path-to-your-dblend-php-project>/www` folder.

## Packages
This virtual machine has been created with the following php extensions:

  - php5 
  - php5-cli
  - php5-pgsql 
  - php5-sqlite 
  - php5-intl 
  - php5-mcrypt 
  - php5-apcu 
  - php5-gd
  - phpunit 

PostgreSQL is the database server:

  - postgresql
  - postgresql-contrib 

Of course, `git` and the `heroku-toolelt` are present too.

## Database configuration

### Local
This machine is setup with two postgrSQL databases: `my_app`, and `my_app_test`.
The last one is meant to be used if you run phpunit tests against your code.

The default configuration to access your databases are:

```
host: localhost
db name : my_app (or my_app_test)
user: vagrant
password: vagrant
```

### Heroku
To use a postgreSQL database on Heroku, you will need the Heroku-Postgres addon. You can enable it using the toolbelt with this command: `heroku addons:create heroku-postgresql:hobby-dev`

Heroku uses environment variables, so when you want to deploy your application on it, you have to use this configuration:

```php
// Use the DATABASE_URL environment variable
$db = parse_url(getenv('DATABASE_URL'));

// Then, access the properties like this:
$host =     $db['host'];
$username = $db['user'];
$password = $db['pass'];
$database = ltrim($db["path"],'/');
```

For your comfort, the **same environment variable has been setup** for the `my_app` database. That way, you don't have to bother on the differences of configuration between this virtual machine and heroku.

## Pushing your commits to Heroku
A simple step by step method to push your website to heroku:

```bash
# You must be in the /vagrant/www dir:
cd /vagrant/www

# Init a git repo if not already done:
git init

# Commit your changes:
git add .
git commit -m 'Initial commit'

# Create a heroku app:
heroku create

# Push the site:
git push heroku master

# Optionnal: enable postgreSQL on Heroku:
heroku addons:create heroku-postgresql:hobby-dev

# Test the heroku box :
heroku open
```

## Side notes:

There is an empty `composer.json` file in the www directory by default. This file tells Heroku that your application is a PHP application.

The `Procfile` is a file for Heroky to know what type of webserver is needed (in our case, Apache).
