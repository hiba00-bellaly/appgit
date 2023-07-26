# Use the official PHP with Apache image
FROM php:8.2.8-fpm

# Install PHP and related extensions for Laravel
RUN docker-php-ext-install pdo_mysql

# Install required system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /var/www/html

# Copy Nginx server configuration
COPY nginx/nginx.conf /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Copy Laravel project files to the container
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Laravel dependencies
RUN composer install

# Generate the Laravel encryption key
RUN php artisan key:generate

# Expose port 80 (you might need to expose port 443 for HTTPS if you are using it)
EXPOSE 80

# Start Nginx and PHP-FPM
CMD service nginx start && php-fpm

# You can also use the following CMD to keep PHP-FPM and Nginx processes running separately.
# CMD ["php-fpm"]
# CMD ["nginx", "-g", "daemon off;"]
