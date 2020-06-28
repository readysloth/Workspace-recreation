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
emerge --oneshot sys/apps/portage

eselect profile list

printf 'select profile: '
read profile_choice

eselect profile set "${profile_choice}"

eselect profile list

emerge --update --deep --newuse @world
emerge sys-kernel/gentoo-sources
