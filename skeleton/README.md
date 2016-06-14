# Zenias for $Z_LANG

> COMPLETE THIS FILE TO FIT YOUR NEEDS.

## Filesystem
This folder is a shared folder: so you will find its content on the _guest_ machine in the `/vagrant` folder.

## Packages
This virtual machine has been created with the following packages extensions:

> HERE YOU PUT YOUR CUSTOM PACKAGE LIST WITH EXPLANATIONS

Of course, `git` and the `heroku-toolelt` are present too.


## Database configuration
### Local

```
host: localhost
db name : my_app
user: vagrant
password: vagrant
```

### Heroku
To use a postgreSQL database on Heroku, you will need the Heroku-Postgres addon. You can enable it using the toolbelt with this command: `heroku addons:create heroku-postgresql:hobby-dev`

## Pushing your commits to Heroku
A simple step by step method to push your website to heroku:

```bash
# You must be in the /vagrant/working_dir dir:
cd /vagrant/working_dir

# Init a git repo if not already done:
git init

# Commit your changes:
git add .
git commit -m 'Initial commit'

# Create a heroku app:
heroku create

# Push the site:
git push heroku master

# Test the heroku box :
heroku open
```

## Side notes:
