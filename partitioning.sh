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

LVM_GROUP_NAME="vg01"

wipefs -a "${DISK}"

EXISTING_LVM_GROUPS="$(vgs | sed -n 2,\$p | awk '{print $1}')"
vgremove -y "${EXISTING_LVM_GROUPS}"

parted -a optimal --script "${DISK}" 'mklabel gpt'
parted -a optimal --script "${DISK}" 'mkpart primary 1MiB 3MiB'
parted -a optimal --script "${DISK}" 'name 1 grub'
parted -a optimal --script "${DISK}" 'set 1 bios_grub on'

parted -a optimal --script "${DISK}" 'mkpart primary 3MiB 259MiB'
parted -a optimal --script "${DISK}" 'name 2 boot'
parted -a optimal --script "${DISK}" 'set 2 boot on'

parted -a optimal --script "${DISK}" 'mkpart primary 259MiB -1'
parted -a optimal --script "${DISK}" 'name 3 lvm01'
parted -a optimal --script "${DISK}" 'set 3 lvm on'

print_if_verbatim parted -a optimal --script "${DISK}" 'print'

/etc/init.d/lvm start
pvcreate "${DISK_PART3}"

print_if_verbatim pvdisplay

vgcreate vg01 "${DISK_PART3}"

lvcreate -y -L 1024M   -n swap   "${LVM_GROUP_NAME}"
lvcreate -y -l 40%FREE -n rootfs "${LVM_GROUP_NAME}"
lvcreate -y -l 60%FREE -n home   "${LVM_GROUP_NAME}"

mkfs.fat -F 32 "${DISK_PART2}"
mkfs.ext4 /dev/"${LVM_GROUP_NAME}"/rootfs
mkfs.ext4 /dev/"${LVM_GROUP_NAME}"/home

mkswap /dev/"${LVM_GROUP_NAME}"/swap
swapon /dev/"${LVM_GROUP_NAME}"/swap

mount /dev/"${LVM_GROUP_NAME}"/rootfs /mnt/gentoo

mkdir /mnt/gentoo/home
mount /dev/"${LVM_GROUP_NAME}"/home /mnt/gentoo/home

./preinstallation.sh "${DISK}"
