import sys
import select

from utils import call_cmd_and_print_cmd, source

def compile(boot_device: str):
    call_cmd_and_print_cmd('emerge --update --deep --newuse @world')
    call_cmd_and_print_cmd('echo "app-editors/vim X python vim-pager perl terminal" >> /etc/portage/package.use/vim')
    call_cmd_and_print_cmd('emerge app-editors/vim')

    call_cmd_and_print_cmd(f'echo "/dev/{boot_device} /boot fat32 defaults 0 2" >> /etc/fstab')
    call_cmd_and_print_cmd('''echo 'ACCEPT_LICENSE="*"'     >> /etc/portage/make.conf''')
    call_cmd_and_print_cmd('''echo 'USE="abi_x86_32 abi_x86_64 -gpm"' >> /etc/portage/make.conf''')

    call_cmd_and_print_cmd('emerge sys-kernel/gentoo-sources')
    call_cmd_and_print_cmd('emerge --autounmask-write sys-kernel/genkernel')
    call_cmd_and_print_cmd('echo -5 | etc-update')
    call_cmd_and_print_cmd('emerge sys-kernel/genkernel')

    call_cmd_and_print_cmd('genkernel --lvm --mountboot --busybox all')

    call_cmd_and_print_cmd('emerge sys-kernel/linux-firmware')

    configuring()
    install_env()


def configuring():
    call_cmd_and_print_cmd('echo hostname="gentoo" > /etc/conf.d/hostname')

    call_cmd_and_print_cmd(r'''blkid | grep 'boot' |                 sed 's@.*UUID="\([^"]*\)".*@UUID=\1 \t /boot \t swap \t sw \t 0 \t 0@' ''')
    call_cmd_and_print_cmd(r'''blkid | grep 'grub' |                 sed 's@.*UUID="\([^"]*\)".*@UUID=\1 \t /boot/grub \t vfat \t umask=0077 \t 0 \t 1@' >> /etc/fstab''')

    call_cmd_and_print_cmd(r'''blkid | grep 'swap' |                 sed 's@.*UUID="\([^"]*\)".*@UUID=\1 \t none \t swap \t sw \t 0 \t 0@'               >> /etc/fstab''')
    call_cmd_and_print_cmd(r'''blkid | grep 'ext4' | grep 'rootfs' | sed 's@.*UUID="\([^"]*\)".*@UUID=\1 \t / \t ext4 \t noatime \t 0 \t 1@'             >> /etc/fstab''')
    call_cmd_and_print_cmd(r'''blkid | grep 'ext4' | grep 'home'   | sed "s@.*UUID=\"\([^\"]*\)\".*@UUID=\1 \t /home/ \t ext4 \t noatime \t 0 \t 1@"     >> /etc/fstab''')

    call_cmd_and_print_cmd('pushd /etc/init.d && ln -s net.lo net.eth0 && rc-update add net.eth0 default && popd')


    call_cmd_and_print_cmd('emerge app-admin/sysklogd')
    call_cmd_and_print_cmd('rc-update add sysklogd default')

    call_cmd_and_print_cmd('emerge sys-process/cronie')
    call_cmd_and_print_cmd('rc-update add cronie default')

    call_cmd_and_print_cmd('emerge sys-apps/mlocate')
    call_cmd_and_print_cmd('emerge sys-fs/e2fsprogs')
    call_cmd_and_print_cmd('emerge net-misc/dhcpcd')
    call_cmd_and_print_cmd('emerge net-wireless/iw')
    call_cmd_and_print_cmd('emerge net-wireless/wpa_supplicant')

    call_cmd_and_print_cmd('''echo 'GRUB_PLATFORMS="emu efi-32 efi-64 pc"' >> /etc/portage/make.conf''')
    call_cmd_and_print_cmd('emerge sys-boot/grub:2')


    call_cmd_and_print_cmd('''echo 'GRUB_CMDLINE_LINUX="dolvm"' >> /etc/default/grub''')

    call_cmd_and_print_cmd('''grub-install --target=$(lscpu | head -n1 | sed 's/^[^:]*:[[:space:]]*//')-efi --efi-directory=/boot --removable''')
    call_cmd_and_print_cmd('''grub-mkconfig -o /boot/grub/grub.cfg''')

    call_cmd_and_print_cmd('emerge --autounmask-write sys-boot/os-prober')
    call_cmd_and_print_cmd('echo -5 | etc-update')
    call_cmd_and_print_cmd('emerge sys-boot/os-prober')


def install_env():
    call_cmd_and_print_cmd('bash environment_install.sh')

