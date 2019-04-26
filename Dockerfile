FROM php:7.1-apache

EXPOSE 80

RUN apt-get update && apt-get install --no-install-recommends -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libldap2-dev \
        git \
        && rm -rf /var/lib/apt/lists/*
RUN a2enmod rewrite

RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install exif
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd
RUN docker-php-ext-install ldap
RUN docker-php-ext-install zip
RUN pecl install mailparse && docker-php-ext-enable mailparse

RUN sed -i 's/max_execution_time = .*/max_execution_time = '180'/' /usr/local/etc/php/php.ini-development
RUN sed -i 's/max_input_time = .*/max_input_time = '180'/' /usr/local/etc/php/php.ini-development
RUN sed -i 's/memory_limit = .*/memory_limit = '256M'/' /usr/local/etc/php/php.ini-development
RUN sed -i 's/post_max_size = .*/post_max_size = '25M'/' /usr/local/etc/php/php.ini-development
RUN sed -i 's/upload_max_filesize = .*/upload_max_filesize = '25M'/' /usr/local/etc/php/php.ini-development
RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

COPY ./composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer
WORKDIR /var/www/html/

RUN composer create-project treolabs/treocore ./

# Set permissions for directory /data /custom /client/custom /application
RUN mkdir ./client/custom\
find . -type d -exec chmod 755 {} + && find . -type f -exec chmod 644 {} +;\
find data custom client/custom -type d -exec chmod 775 {} + && find data custom client/custom -type f -exec chmod 664 {} +;\
chmod 775 application/Espo/Modules client/modules;
RUN chown -R www-data:www-data .

# install module PIM
RUN /usr/local/bin/php console.php composer require treo-module/pim
RUN /usr/local/bin/php composer.phar update