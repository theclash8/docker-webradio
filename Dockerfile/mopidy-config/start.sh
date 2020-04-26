#!/bin/bash

env

set -x

set_val() {
    if [ -n "$2" ]; then
        echo "set '$2' to '$1'"
	if [ "s$2" == "ssource_password" ]; then
		sed -i "s/password = xxxx/password = $1/g" /config/mopidy.conf
	fi
	if [ "s$2" == "sspoty_password" ]; then
                sed -i "s/password = yyyy/password = $1/g" /config/mopidy.conf
	else
	        sed -i "s/$2 = .*/$2 = $1/g" /config/mopidy.conf
	fi
    else
        echo "ERROR: setting for '$1' is missing!" >&2

	exit
    fi
}

if [ ! -f "/config/mopidy.conf" ]; then 
	cp /root/mopidy.conf.template /config/mopidy.conf
	set_val $MOPIDY_SOURCE_PASSWORD source_password
	set_val $SPOTIFY_USERNAME username
	set_val $SPOTIFY_PASSWORD spoty_password
	set_val $SPOTIFY_CLIENT_ID client_id
	set_val $SPOTIFY_CLIENT_SECRET client_secret
fi

set -e

mopidy --config /config/mopidy.conf local scan
mopidy --config /config/mopidy.conf
