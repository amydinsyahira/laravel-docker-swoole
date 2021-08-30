FROM php:7.4-fpm-alpine

RUN apk add --no-cache \
        git \
		acl \
		fcgi \
		file \
		gettext \
        supervisor \
	;

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN set -exu; \
    install-php-extensions pdo_mysql swoole mbstring exif gd intl zip pcntl apcu opcache bcmath @composer; \
    rm /usr/local/bin/install-php-extensions;

WORKDIR /app

COPY ./app/laravel-swoole-tutorial .

RUN composer install --prefer-dist --no-scripts --no-progress; \
    composer dump-autoload --classmap-authoritative;

RUN	chmod +x artisan; sync;

COPY ./docker/configuration-init.sh /usr/local/bin/configuration-init
COPY ./docker/php/supervisord.conf /etc/supervisord.conf

RUN set -exu; \
    chmod +x /usr/local/bin/configuration-init; \
    configuration-init; \
    rm /usr/local/bin/configuration-init;

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]