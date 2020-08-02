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

passwd

emerge app-admin/sysklogd
rc-update add sysklogd default

emerge sys-process/cronie
rc-update add cronie default

emerge sys-apps/mlocate

emerge sys-fs/e2fsprogs

emerge net-misc/dhcpcd

emerge net-wireless/iw net-wireless/wpa_supplicant


#installing bootloader

echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
emerge sys-boot/grub:2

grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

exit
    cd
    umount -l /mnt/gentoo/dev{/shm,/pts,}
    umount -R /mnt/gentoo
    reboot
