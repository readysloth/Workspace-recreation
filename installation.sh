#!/usr/bin/env bash

print_if_verbatim(){
    if ! [ -z "$VERBOSE" ]; then
        eval "$@"
    fi
}

DISK="$1"

source /etc/profile

BOOT_PARTITION=$(parted --script "${DISK}" | grep 'boot' | awk '{print $1}')

mount /dev/"${DISK}${BOOT_PARTITION}" /boot

emerge-webrsync
emerge --sync
emerge --oneshot sys/apps/portage

eselect profile list

printf 'select profile: '
read profile_choice

eselect profile set "${profile_choice}"

eselect profile list

./compiling.sh
