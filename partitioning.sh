#!/bin/env bash

print_if_verbatim(){
    if ! [ -z "$VERBOSE" ]; then
        eval "$@"
    fi
}

print_if_verbatim set -x

DISK="$1"
DISK_PART1="${DISK}1"
DISK_PART2="${DISK}2"
DISK_PART3="${DISK}3"

wipefs -a "$DISK"

parted -a optimal --script "$DISK" 'mklabel gpt'
parted -a optimal --script "$DISK" 'mkpart primary 1MiB 3MiB'
parted -a optimal --script "$DISK" 'name 1 grub'
parted -a optimal --script "$DISK" 'set 1 bios_grub on'

parted -a optimal --script "$DISK" 'mkpart primary 3MiB 131MiB'
parted -a optimal --script "$DISK" 'name 2 boot'
parted -a optimal --script "$DISK" 'set 2 boot on'

parted -a optimal --script "$DISK" 'mkpart primary 131MiB -1'
parted -a optimal --script "$DISK" 'name 3 lvm01'
parted -a optimal --script "$DISK" 'set 3 lvm on'

print_if_verbatim parted -a optimal --script "$DISK" 'print'

/etc/init.d/lvm start
pvcreate "$DISK_PART3"

print_if_verbatim pvdisplay

vgcreate vg01 "$DISK_PART3"

lvcreate -L 1024M -n swap vg01
lvcreate -l 20%FREE -n rootfs vg01
lvcreate -l 80%FREE -n home vg01
