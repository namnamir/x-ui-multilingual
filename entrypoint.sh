#!/bin/ash

if [ ! -f /etc/x-ui/x-ui.db ]; then
    ./x-ui setting -port $X_UI_PORT
    ./x-ui setting -username $X_UI_USERNAME -password $X_UI_PASSWORD
fi

exec "$@";
