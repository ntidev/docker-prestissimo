FROM php:7.2-cli-alpine

RUN apk add --no-cache --virtual .build-dependencies zip zlib-dev \
    && docker-php-ext-install zip \
    && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer global require hirak/prestissimo \
    && apk del .build-dependencies \
    && apk add --no-cache git

COPY ./custom.ini /usr/local/etc/php/conf.d/

WORKDIR /app

ENTRYPOINT ["composer"]
