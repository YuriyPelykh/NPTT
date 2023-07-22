FROM php:8-fpm

COPY ./app /var/www/html

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli && \
    if [ ! -f ./wp-config.php ]; then \
        cp ./wp-config-sample.php ./wp-config.php && \
        sed -i "s/'DB_NAME', '[a-z,_]*'/'DB_NAME', getenv('DB_NAME')/g" wp-config.php && \
        sed -i "s/'DB_USER', '[a-z,_]*'/'DB_USER', getenv('DB_USER')/g" wp-config.php &&\
        sed -i "s/'DB_PASSWORD', '[a-z,_]*'/'DB_PASSWORD', getenv('DB_PASSWORD')/g" wp-config.php &&\
        sed -i "s/'DB_HOST', '[a-z,_]*'/'DB_HOST', getenv('DB_HOST')/g" wp-config.php \
    ; fi
