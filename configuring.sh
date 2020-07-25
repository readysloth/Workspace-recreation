#!/usr/bin/env bash

print_if_verbatim(){
    if ! [ -z "$VERBOSE" ]; then
        eval "$@"
    fi
}

printf 'Enter hostname: '
read hostname

echo hostname="$hostname" > /etc/conf.d/hostname


blkid | grep 'boot' |                 sed 's@.*UUID="\([^"]*\)".*@UUID=\1 \t /boot \t swap \t sw \t 0 \t 0@'
blkid | grep 'grub' |                 sed 's@.*UUID="\([^"]*\)".*@UUID=\1 \t /boot/grub \t vfat \t umask=0077 \t 0 \t 1@' >> /etc/fstab

blkid | grep 'swap' |                 sed 's@.*UUID="\([^"]*\)".*@UUID=\1 \t none \t swap \t sw \t 0 \t 0@' >> /etc/fstab
blkid | grep 'ext4' | grep 'rootfs' | sed 's@.*UUID="\([^"]*\)".*@UUID=\1 \t / \t ext4 \t noatime \t 0 \t 1@' >> /etc/fstab
blkid | grep 'ext4' | grep 'home'   | sed "s@.*UUID=\"\([^\"]*\)\".*@UUID=\1 \t /home/$hostname \t ext4 \t noatime \t 0 \t 1@" >> /etc/fstab


pushd /etc/init.d
    ln -s net.lo net.eth0
    rc-update add net.eth0 default
popd
