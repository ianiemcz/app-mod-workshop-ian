# Use the official PHP 7.3 image with Apache
FROM php:7.3-apache

# Define the env variable for the Apache listening port 8080 and app name as well as php env
ENV myPORT=8080
ENV APP_NAME "PHP Amarcord from Dockerfile"
ENV PHP_ENV 'DFLT_DOCKERFILE'

# Install the MySQL extension
RUN docker-php-ext-install mysqli
#        /usr/local/bin/docker-php-ext-install -j5 gd mbstring mysqli pdo pdo_mysql shmop
RUN docker-php-ext-install -j5 mysqli pdo pdo_mysql

# Copy in custom code from the host machine.
WORKDIR /var/www/html
COPY ./ /var/www/html

# to make uploads doable ?
RUN chmod 777 /var/www/html/uploads/

# Use the PORT environment variable in Apache configuration files.
# https://cloud.google.com/run/docs/reference/container-contract#port
RUN sed -i 's/80/${myPORT}/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf

# When in doubt, always expose to port 8080
EXPOSE 8080

# Configure PHP for development.
# Switch to the production php.ini for production operations.
# RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
# https://github.com/docker-library/docs/blob/master/php/README.md#configuration
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Start Apache in the foreground
CMD ["apache2-foreground"]
