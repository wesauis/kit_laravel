# base image including just whe bare minimum
FROM docker.io/dunglas/frankenphp:1.1.3-php8.3-alpine AS runtime_envirnoment

# install composer + laravel required php extensions + mysql php driver
RUN install-php-extensions \
    pcntl BCMath Ctype cURL DOM Fileinfo JSON Mbstring OpenSSL PCRE PDO Tokenizer XML \
    pdo_mysql

ENTRYPOINT ["php", "artisan", "octane:frankenphp"]


# execute building steps for the production image
FROM runtime_envirnoment AS production_builder

# install composer + laravel required php extensions + mysql php driver
RUN install-php-extensions @composer

# install and cache dependencies
COPY composer.lock composer.json .
RUN composer install --no-interaction --optimize-autoloader --no-dev --no-scripts --ansi


# use the built image + code for production
FROM production_builder AS production

# copy deps
COPY --from=production_builder /app/vendor /app

# copy code
COPY . /app


# mount development envirnoment
FROM runtime_envirnoment AS development

RUN install-php-extensions @composer
COPY composer.lock composer.json .
RUN composer install --no-interaction --optimize-autoloader --no-scripts --ansi

ENTRYPOINT ["/bin/sh", "-c", "php artisan octane:frankenphp --workers=1 --max-requests=1 || sleep Infinity"]
