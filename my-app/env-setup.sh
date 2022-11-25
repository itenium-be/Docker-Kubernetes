#!/bin/bash

sed -i -e 's#MY_MESSAGE#'"$my_message"'#g' /usr/share/nginx/html/index.html
nginx -g 'daemon off;'