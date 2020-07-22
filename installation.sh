#!/usr/bin/env bash

print_if_verbatim(){
    if ! [ -z "$VERBOSE" ]; then
        eval "$@"
    fi
}


BOOT="$1"

source /etc/profile

mount "${BOOT}" /boot

emerge-webrsync
emerge --sync
emerge --oneshot sys/apps/portage

eselect profile list

printf 'select profile: '
read profile_choice

eselect profile set "${profile_choice}"

eselect profile list

./compiling.sh
