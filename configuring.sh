#!/usr/bin/env bash

print_if_verbatim(){
    if ! [ -z "$VERBOSE" ]; then
        eval "$@"
    fi
}

set -o errexit

printf 'Enter hostname: '
read -t 20 hostname || hostname=gentoo

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

emerge app-admin/sysklogd
rc-update add sysklogd default

emerge sys-process/cronie
rc-update add cronie default

./with_tmpfs.sh ' ' 'sys-apps/mlocate'

./with_tmpfs.sh ' ' 'sys-fs/e2fsprogs'

./with_tmpfs.sh ' ' 'net-misc/dhcpcd'

./with_tmpfs.sh ' ' 'net-wireless/iw'

./with_tmpfs.sh ' ' 'net-wireless/wpa_supplicant'

#installing bootloader

echo 'GRUB_PLATFORMS="emu efi-32 efi-64 pc"' >> /etc/portage/make.conf
./with_tmpfs.sh ' ' 'sys-boot/grub:2'

grub-install --target=$(lscpu | head -n1 | sed 's/^[^:]*:[[:space:]]*//')-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

emerge sys-boot/os-prober

passwd

exit
    cd
    umount -l /mnt/gentoo/dev{/shm,/pts,}
    umount -R /mnt/gentoo
    reboot
