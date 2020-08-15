#!/usr/bin/env bash

print_if_verbatim(){
    if ! [ -z "$VERBOSE" ]; then
        eval "$@"
    fi
}

set -o errexit


emerge --update --deep --newuse @world

echo "/dev/${BOOT_PARTITION} /boot fat32 defaults 0 2" >> /etc/fstab
echo 'ACCEPT_LICENSE="*"' >> /etc/portage/make.conf
emerge sys-kernel/gentoo-sources
emerge --autounmask-write sys-kernel/genkernel
echo -5 | etc-update
emerge sys-kernel/genkernel

genkernel all

emerge sys-kernel/linux-firmware
emerge vim

./configuring.sh
