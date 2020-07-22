#!/usr/bin/env bash

print_if_verbatim(){
    if ! [ -z "$VERBOSE" ]; then
        eval "$@"
    fi
}

printf 'Enter hostname: '
read hostname

echo hostname="$hostname" > /etc/conf.d/hostname

pushd /etc/init.d
    ln -s net.lo net.eth0
    rc-update add net.eth0 default
popd
