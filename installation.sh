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
mkdir /home/gentoo


emerge-webrsync
emerge --oneshot sys-apps/portage

# For queries in future
emerge app-portage/gentoolkit

eselect profile list

printf 'select profile: '
# Magic number for desktop version. Would it change some day?...
read -t 30 profile_choice || profile_choice=20

eselect profile set "${profile_choice}"

eselect profile list

./compiling.sh
