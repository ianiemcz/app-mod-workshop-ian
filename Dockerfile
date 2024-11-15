# Use the official PHP 7.3 image with Apache
FROM php:7.3-apache

# Define the env variable for the Apache listening port 8080
ENV myPORT=8080

# Configure PHP for Cloud Run.
# Precompile PHP code with opcache.
RUN docker-php-ext-install pdo pdo_mysql

# Copy in custom code from the host machine.
WORKDIR /var/www/html
COPY . ./

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
