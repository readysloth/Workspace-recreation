#!/usr/bin/env bash

print_if_verbatim(){
    if ! [ -z "$VERBOSE" ]; then
        eval "$@"
    fi
}

set -o errexit

BOOT="$1"

source /etc/profile

mount "${BOOT}" /boot


emerge-webrsync
emerge --sync
emerge --oneshot sys-apps/portage

eselect profile list

printf 'select profile: '
# Magick number for desktop version. Would it change some day?...
read profile_choice || profile_choice=20

eselect profile set "${profile_choice}"

eselect profile list

./compiling.sh
