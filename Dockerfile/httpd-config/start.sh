#!/bin/bash

env

set -x

set_val() {
  if [ -n "$2" ]; then
    echo "set '$2' to '$1'"
		sed -i "s/$2/$1/g" /usr/local/apache2/htdocs/index.html
  else
    echo "ERROR: setting for '$1' is missing!" >&2
  fi
}

	
if [ ! -f "/usr/local/apache2/htdocs" ]; then 
  cp /root/index.html.template /usr/local/apache2/htdocs/index.html
  set_val $WEBRADIO_HOST WEBRADIO_HOST
fi

set -e

htpasswd -b -c /.htpasswd admin ${ADMIN_PASSWORD}
httpd-foreground
