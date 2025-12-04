FROM php:8.1-apache

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable Apache rewrite
RUN a2enmod rewrite

# Copy project files into container
COPY . /var/www/html/

# Ensure uploads directory exists
RUN mkdir -p /var/www/html/uploads

# access.log

# Fix permissions for Apache/PHP (intentionally insecure for lab)
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 777 /var/www/html \
    && chmod -R 777 /var/www/html/uploads
