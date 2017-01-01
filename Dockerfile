FROM alpine:edge
MAINTAINER Alain Knaebel <alain.knaebel@aknaebel.fr>

RUN echo "http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
 && echo "http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && BUILD_DEPS="gnupg tar build-base autoconf automake libtool" \

 && apk upgrade --update \
 && apk add ca-certificates openssl \
      php7-fpm php7 php7-ctype php7-dom php7-gd php7-iconv php7-json php7-xml php7-mbstring php7-posix php7-zip php7-zlib php7-session \
      php7-mcrypt php7-json php7-curl php7-gd php7-openssl \
      wget \

 && echo "date.timezone = 'UTC'" >> /etc/php7/php.ini \
 && echo "short_open_tag = 0" >> /etc/php7/php.ini \

 && addgroup -g 82 -S www-data \
 && adduser -u 82 -D -S -G www-data www-data \

 && mkdir -p /run/php/ /dokuwiki /var/www \
 && wget -O /tmp/dokuwiki-stable.tgz http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz \
 && tar xzvf /tmp/dokuwiki-stable.tgz -C /dokuwiki --strip-components 1 \
 && cp -R /dokuwiki /var/www/dokuwiki \

 && rm -rf /var/cache/apk/* /tmp/* \
 && chown -R www-data:www-data /var/www/dokuwiki

WORKDIR /var/www/dokuwiki
VOLUME /var/www/dokuwiki
VOLUME /var/www/dokuwiki/data
VOLUME /var/www/dokuwiki/lib/plugins
VOLUME /var/www/dokuwiki/conf
VOLUME /var/www/dokuwiki/lib/tpl

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
COPY ./php-fpm.conf /etc/php7/php-fpm.conf

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["php-fpm7", "-F"]
