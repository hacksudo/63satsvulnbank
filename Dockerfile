FROM php:8.1-apache

RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN a2enmod rewrite

# Allow .htaccess
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

# Copy application files
COPY . /var/www/html/

# Fix permissions for entire web root
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 777 /var/www/html

# Ensure uploads directory exists + is writable
RUN mkdir -p /var/www/html/uploads
RUN chown -R www-data:www-data /var/www/html/uploads 
RUN chmod -R 777 /var/www/html/uploads
RUN chmod 777 /var/www/html/uploads

# Enable log poisoning RCE
RUN mkdir -p /var/log/apache2 \
    && chmod -R 777 /var/log/apache2 \
    && touch /var/log/apache2/access.log
