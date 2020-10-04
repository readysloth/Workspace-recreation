#!/usr/bin/env bash

print_if_verbatim(){
    if ! [ -z "$VERBOSE" ]; then
        eval "$@"
    fi
}

set -o errexit

  
if ! [ -z "$CCACHE" ]; then
    emerge dev-util/ccache
    echo 'FEATURES="ccache"' >> /etc/portage/make.conf
    echo 'CCACHE_DIR="/var/tmp/ccache"' >> /etc/portage/make.conf
fi

./with_tmpfs.sh '--update --deep --newuse' '@world'

# Adding vim USE flags
echo 'app-editors/vim X python vim-pager perl terminal' >> /etc/portage/package.use/vim
./with_tmpfs.sh ' ' 'app-editors/vim'

echo "/dev/${BOOT_PARTITION} /boot fat32 defaults 0 2" >> /etc/fstab
echo 'ACCEPT_LICENSE="*"'     >> /etc/portage/make.conf
echo 'ACCEPT_KEYWORDS="**"' >> /etc/portage/make.conf
echo 'USE="abi_x86_32 abi_x86_64 -gpm"' >> /etc/portage/make.conf

./with_tmpfs.sh ' ' 'sys-kernel/gentoo-sources'
./with_tmpfs.sh '--autounmask-write' 'sys-kernel/genkernel'
echo -5 | etc-update
./with_tmpfs.sh '' 'sys-kernel/genkernel'

GENKERNEL_OPTIONS='--lvm --mountboot --busybox'

set +o errexit
[ "$(grep -i memtotal /proc/meminfo | awk '{print $2}')" -lt '6000000' ] && sed -i '/\/var\/tmp\/portage/d' /etc/fstab && umount /var/tmp/portage
set -o errexit

genkernel $GENKERNEL_OPTIONS all

./with_tmpfs.sh ' ' 'sys-kernel/linux-firmware'

./configuring.sh
