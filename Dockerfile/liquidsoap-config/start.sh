#!/bin/sh

env

set -x

set_val() {
    if [ -n "$2" ]; then
        echo "set '$2' to '$1'"
        sed -i "s/source_password=\".*\"/source_password=\"$1\"/g" /config/passwords.liq
    else
        echo "ERROR: setting for '$1' is missing!" >&2
	exit
    fi
}

if [ ! -f /config/passwords.liq ]; then
	cp /root/passwords.liq.template /config/passwords.liq
	cp /root/main.liq.template /config/main.liq
	set_val $ICECAST_SOURCE_PASSWORD source_password
	wget -O /data/test.mp3 https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_5MG.mp3
fi


set -e

supervisord -n
