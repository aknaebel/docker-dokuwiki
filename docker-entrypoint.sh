#!/bin/sh

echo >&2 "Setting Permissions:"
path='/var/www/dokuwiki'
htuser='www-data'

if [ "$(ls -A ${path}/lib/plugins)" ]; then
    chown -R ${htuser}:${htuser} ${path}
else
    cp -R /dokuwiki/* /var/www/dokuwiki
    chown -R ${htuser}:${htuser} ${path}
fi

exec "$@"
