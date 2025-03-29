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

# Crear carpetas necesarias
RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache

# Establecer permisos
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# NO instales Composer, ya está todo preparado
# WORKDIR /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
