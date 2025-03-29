FROM php:8.2-apache

# Instala dependencias
RUN apt-get update && apt-get install -y \
    libzip-dev unzip git curl \
    && docker-php-ext-install zip pdo pdo_mysql

# Habilita mod_rewrite
RUN a2enmod rewrite

# Copia el código de la app al contenedor
COPY . /var/www/html/

# Establece permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Corre Composer para instalar dependencias
RUN composer install --no-interaction --no-dev --optimize-autoloader

# Expone el puerto 80
EXPOSE 80
