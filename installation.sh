#!/usr/bin/env bash

print_if_verbatim(){
    if ! [ -z "$VERBOSE" ]; then
        eval "$@"
    fi
}


source /etc/profile

mount /dev/sda2 /boot

emerge-webrsync

emerge --sync
