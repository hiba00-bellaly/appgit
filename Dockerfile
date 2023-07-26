# Use the official PHP 8.2.8 FPM Alpine image
FROM php:8.2.8-fpm-alpine

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install required system packages and PHP extensions for MySQL
RUN set -ex \
    && apk --no-cache add mysql-client nodejs yarn npm \
    && docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www/html

