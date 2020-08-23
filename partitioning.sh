#!/bin/env bash

# Debugging function. To set it, use `export VERBOSE=1`
print_if_verbatim(){
    if ! [ -z "$VERBOSE" ]; then
        eval "$@"
    fi
}

# Setting bash debugging print
print_if_verbatim set -x

# Disk to partition
DISK="$1"

LVM_GROUP_NAME="vg01"

# Wiping existing filesystem on disk
wipefs -af "${DISK}"

# Removing any existing lvm groups
EXISTING_LVM_GROUPS="$(vgs | sed -n 2,\$p | awk '{print $1}')"
vgremove -y "${EXISTING_LVM_GROUPS}"

set -o errexit
# Making bootloader partition
parted -a optimal --script "${DISK}" 'mklabel gpt'
parted -a optimal --script "${DISK}" 'mkpart primary 1MiB 3MiB'
parted -a optimal --script "${DISK}" 'name 1 grub'
parted -a optimal --script "${DISK}" 'set 1 bios_grub on'

# Making boot partition
parted -a optimal --script "${DISK}" 'mkpart primary 3MiB 259MiB'
parted -a optimal --script "${DISK}" 'name 2 boot'
parted -a optimal --script "${DISK}" 'set 2 boot on'

# Mapping free space to lvm
parted -a optimal --script "${DISK}" 'mkpart primary 259MiB -1'
parted -a optimal --script "${DISK}" 'name 3 lvm01'
parted -a optimal --script "${DISK}" 'set 3 lvm on'

print_if_verbatim parted -a optimal --script "${DISK}" 'print'

# Getting device names of made partitions
DISK_PART1="$(fdisk -l | grep ${DISK} | tail -n +2 | sed -n 1p | awk '{print $1}')"
DISK_PART2="$(fdisk -l | grep ${DISK} | tail -n +2 | sed -n 2p | awk '{print $1}')"
DISK_PART3="$(fdisk -l | grep ${DISK} | tail -n +2 | sed -n 3p | awk '{print $1}')"

# Starting lvm daemon
/etc/init.d/lvm start

# Creating physical volume for lvm
pvcreate "${DISK_PART3}"

print_if_verbatim pvdisplay

vgcreate vg01 "${DISK_PART3}"

# Allocating space for logical volumes
lvcreate -y -L 3072M   -n swap   "${LVM_GROUP_NAME}"
lvcreate -y -l 40%FREE -n rootfs "${LVM_GROUP_NAME}"
lvcreate -y -l 60%FREE -n home   "${LVM_GROUP_NAME}"

# Making filesystems
mkfs.fat -F 32 "${DISK_PART2}"
mkfs.ext4 /dev/"${LVM_GROUP_NAME}"/rootfs
mkfs.ext4 /dev/"${LVM_GROUP_NAME}"/home

# Making swap
mkswap /dev/"${LVM_GROUP_NAME}"/swap
swapon /dev/"${LVM_GROUP_NAME}"/swap

# Mounting device for OS installation
mount /dev/"${LVM_GROUP_NAME}"/rootfs /mnt/gentoo

mkdir /mnt/gentoo/home
mount /dev/"${LVM_GROUP_NAME}"/home /mnt/gentoo/home

# Going to preinstallation phase, passing disk name further
time ./preinstallation.sh "${DISK}"

# Removing our installation tmpfs from fstab
sed -i '/\/var\/tmp\/portage/d' /etc/fstab && umount /var/tmp/portage

passwd


exit
cd
umount -l /mnt/gentoo/dev{/shm,/pts,}
umount -R /mnt/gentoo
reboot
