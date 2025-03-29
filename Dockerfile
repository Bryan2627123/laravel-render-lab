FROM php:8.1-apache

# Instalar extensiones necesarias
RUN apt-get update && apt-get install -y \
    zip unzip git curl libzip-dev \
    && docker-php-ext-install zip pdo pdo_mysql

# Habilitar mod_rewrite de Apache
RUN a2enmod rewrite

# Copiar el contenido del proyecto a /var/www/html
COPY . /var/www/html

# Cambiar el DocumentRoot a la carpeta public/
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|' /etc/apache2/sites-available/000-default.conf

# Crear carpetas necesarias para Laravel
RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache

# Establecer permisos necesarios
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Instalar Composer
WORKDIR /var/www/html
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer install --no-interaction --optimize-autoloader --no-dev

EXPOSE 80
CMD ["apache2-foreground"]

