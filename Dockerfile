FROM php:8.2.8-apache
# Set the working directory in the container
WORKDIR /var/www/html

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql 

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the project files to the container
COPY . .

RUN apt-get update && apt-get install -y git


# Generate the Laravel encryption key
RUN php artisan key:generate

# Expose port 80 for the Apache server
EXPOSE 80

# Start the Apache server
CMD ["apache2-foreground"]
