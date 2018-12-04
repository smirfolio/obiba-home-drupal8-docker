#
# Mica Drupal client Dockerfile
#
# https://github.com/obiba/obiba-home-drupal8-docker
#

FROM drupal:latest

MAINTAINER OBiBa <dev@obiba.org>

RUN apt-get update && apt-get install -y curl mysql-client wget git

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php composer-setup.php && \
	mv composer.phar /usr/local/bin/composer && \
	php -r "unlink('composer-setup.php');"

# Install Drush
RUN composer global require drush/drush && \
  	ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush && \
  	drush status

COPY data/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY data/20.memory_limit.ini /usr/local/etc/php/conf.d/
COPY data/Makefile /var/www/html/Makefile
COPY bin/start.sh /var/www/html/start.sh
RUN ["chmod", "+x", "/var/www/html/start.sh"]

ENV MYSQL_HOST=db
ENV MYSQL_PASSWORD=1234
# http
EXPOSE 80

# Define default command.
COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["app"]
