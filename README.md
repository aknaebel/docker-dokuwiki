# docker-dokuwiki

## Description:

This docker image provide a [dokuwiki](https://www.dokuwiki.org/dokuwiki#) service based on [Alpine Linux](https://hub.docker.com/_/alpine/) using php7-fpm

## Usage:
```
docker run --name dokuwiki -d -p 9000:9000 \
-v /dokuwiki/data/data:/var/www/dokuwiki/data
-v /dokuwiki/data/plugins:/var/www/dokuwiki/lib/plugins
-v /dokuwiki/data/conf:/var/www/dokuwiki/conf
-v /dokuwiki/data/tpl:/var/www/dokuwiki/lib/tpl
--restart=always aknaebel/dokuwiki
```

## Docker-compose:
``` 
version: '2'
services:
    dokuwiki:
        image: aknaebel/dokuwiki
        expose:
            - 9000
        volumes:
            - ./dokuwiki/data/data:/var/www/dokuwiki/data
            - ./dokuwiki/data/plugins:/var/www/dokuwiki/lib/plugins
            - ./dokuwiki/data/conf:/var/www/dokuwiki/conf
            - ./dokuwiki/data/tpl:/var/www/dokuwiki/lib/tpl
        restart: always
```

```
docker-compose up -d
```

## Dokuwiki stuff

### Volume:
The image provide a volume in **/var/www/dokuwiki**. You must use it with your web server to get the CSS and JS files

### Documentation
See the [official documentation](https://www.dokuwiki.org/dokuwiki#) to configure a specific option of your dokuwiki image
