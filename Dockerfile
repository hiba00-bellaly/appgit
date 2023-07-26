# Use the official Nginx image
FROM php:8.2.8-apache

# Install PHP and related extensions for Laravel
RUN docker-php-ext-install pdo_mysql 
   

# Set the working directory in the container
WORKDIR /var/www/html

# Copy Nginx server configuration
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copy Laravel project files to the container
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Generate the Laravel encryption key
RUN php artisan key:generate

# Start PHP-FPM and Nginx
CMD ["php-fpm7.4", "-R"] 

EXPOSE 80

# Start the Apache server
CMD ["apache2-foreground"]
