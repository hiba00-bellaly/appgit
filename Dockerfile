# Use the official PHP image
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
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copy Laravel project files to the container
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Expose port 80 (you might need to expose port 443 for HTTPS if you are using it)
EXPOSE 80

# Start Nginx and PHP-FPM
CMD ["nginx", "-g", "daemon off;", "php-fpm"]

# Note: The above CMD may not work as expected, alternatively you can use the following:
# CMD service nginx start && php-fpm
