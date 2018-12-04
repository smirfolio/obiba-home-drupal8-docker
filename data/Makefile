#Obiba Drupal Modules intalation 

SHELL := /bin/bash
#mysql
MYSQL_HOST=db
MYSQL_DATABASE_USER=root
MYSQL_PASSWORD=1234
MYSQL_DB=drupal_obiba
#Drupal
www_folder=/var/www/html
DF=drupal-release
Dadm=administrator
Dpassword=password
www_user="www-data"

build-obiba: site-install enable-modules obiba-fix-permission obiba-clear-cache setting-variable

site-install:
	drush site-install standard --account-name=$(Dadm) --account-pass=$(Dpassword) --db-url=mysql://$(MYSQL_DATABASE_USER):$(MYSQL_PASSWORD)@$(MYSQL_HOST)/$(MYSQL_DB) --site-name="Obiba Mica"

obiba-clear-cache:
	drush cc all

enable-modules:
	composer require 'drupal/bootstrap:^3.15'

setting-variable:
	drush config-set system.theme default bootstrap

obiba-fix-permission:
	chown -R $(www_user): *

