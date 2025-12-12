FROM php:8.1-apache

# Install MySQL extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable rewrite module
RUN a2enmod rewrite

# Allow .htaccess execution (RCE allowed)
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/conf-available/docker-php.conf

# Copy all project files
COPY . /var/www/html/

# Ensure uploads directory exists
RUN mkdir -p /var/www/html/uploads

# Fix permissions for uploads (required for move_uploaded_file)
RUN chown -R www-data:www-data /var/www/html/uploads
RUN chmod -R 777 /var/www/html/uploads

# Global permissive permissions (lab purpose only)
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 777 /var/www/html

# Log poisoning for LFI > RCE testing
RUN mkdir -p /var/log/apache2 \
    && touch /var/log/apache2/access.log \
    && chmod -R 777 /var/log/apache2
