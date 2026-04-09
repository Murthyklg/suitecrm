FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip \
    libpng-dev libonig-dev libxml2-dev libicu-dev \
    curl git \
    && docker-php-ext-install \
    pdo pdo_mysql mysqli zip intl gd

# Enable Apache rewrite
RUN a2enmod rewrite

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY php.ini /usr/local/etc/php/
# Copy project
COPY . /var/www/html/

# Install PHP dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Permissions
RUN chown -R www-data:www-data /var/www/html

# Apache config
COPY apache.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80
