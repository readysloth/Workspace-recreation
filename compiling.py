import sys
import select

from utils import call_cmd_and_print_cmd, do_with_fallback, source, USE_emerge_pkg
import environment_install as env_install

def compile():
    call_cmd_and_print_cmd('''echo 'ACCEPT_LICENSE="*"' >> /etc/portage/make.conf''')
    portage_features = 'FEATURES="{}"'.format(' '.join(['parallel-install',
                                                        'parallel-fetch']))
    call_cmd_and_print_cmd('''echo '{}' >> /etc/portage/make.conf'''.format(portage_features))
    call_cmd_and_print_cmd('''echo 'USE="abi_x86_64 lto pgo X openmp"' >> /etc/portage/make.conf''')
    call_cmd_and_print_cmd(r'''echo "EMERGE_DEFAULT_OPTS=\"--jobs=$(( $(nproc) / 2 ))\"" >> /etc/portage/make.conf''')
    call_cmd_and_print_cmd('''echo 'INPUT_DEVICES="synaptics libinput"' >> /etc/portage/make.conf''')

    call_cmd_and_print_cmd('''echo '>sys-devel/gcc-10.3.0-r2' >> /etc/portage/package.mask''')

    call_cmd_and_print_cmd('perl-cleaner --all')
    call_cmd_and_print_cmd('USE="apng" emerge media-libs/libpng')
    call_cmd_and_print_cmd('USE="-harfbuzz -abi_x86_32 -abi_x86_x32" emerge -O1 media-libs/freetype')

    do_with_fallback('emerge -uDNv --with-bdeps=y --backtrack=100 --autounmask-write @world')
    call_cmd_and_print_cmd('echo -5 | etc-update')
    call_cmd_and_print_cmd('emerge -uDNv --with-bdeps=y --backtrack=100 @world')
    call_cmd_and_print_cmd('USE="-abi_x86_32 -abi_x86_x32" emerge ' +
                           'media-libs/freetype ' +
                           'media-libs/harfbuzz ' +
                           'dev-libs/libffi ' +
                           'dev-util/gdbus-codegen ' +
                           'dev-libs/glib ' +
                           '$(equery -q d harfbuzz freetype libffi | sed -e "/^[[:space:]]*$/d" -e "s/.*/=&/g")')

    call_cmd_and_print_cmd('USE="-gpm" emerge -ND sys-libs/ncurses')


    call_cmd_and_print_cmd(USE_emerge_pkg('app-editors/vim', 'X', 'python', 'vim-pager', 'perl', 'terminal'))


    call_cmd_and_print_cmd(USE_emerge_pkg('sys-devel/gcc', 'pgo'))

    call_cmd_and_print_cmd(USE_emerge_pkg('sys-kernel/gentoo-sources'))
    call_cmd_and_print_cmd(USE_emerge_pkg('sys-kernel/genkernel'))

    call_cmd_and_print_cmd('ln -s /usr/src/linux* /usr/src/linux')

    call_cmd_and_print_cmd('genkernel --lvm --mountboot --busybox --install all')

    call_cmd_and_print_cmd(USE_emerge_pkg('sys-kernel/linux-firmware'))

    configuring()
    install_env()


def configuring():
    call_cmd_and_print_cmd('echo hostname="gentoo" > /etc/conf.d/hostname')

    call_cmd_and_print_cmd(r'''blkid | grep 'swap' |                 sed 's@.*UUID="\([^"]*\)".*@UUID=\1 \t none \t swap \t sw \t 0 \t 0@'               >> /etc/fstab''')
    call_cmd_and_print_cmd(r'''blkid | grep 'ext4' | grep 'rootfs' | sed 's@.*UUID="\([^"]*\)".*@UUID=\1 \t / \t ext4 \t noatime \t 0 \t 1@'             >> /etc/fstab''')
    call_cmd_and_print_cmd(r'''blkid | grep 'ext4' | grep 'home'   | sed "s@.*UUID=\"\([^\"]*\)\".*@UUID=\1 \t /home/ \t ext4 \t noatime \t 0 \t 1@"     >> /etc/fstab''')

    call_cmd_and_print_cmd('pushd /etc/init.d && ln -s net.lo net.eth0 && rc-update add net.eth0 default && popd')


    call_cmd_and_print_cmd(USE_emerge_pkg('app-admin/sysklogd'))
    call_cmd_and_print_cmd('rc-update add sysklogd default')

    call_cmd_and_print_cmd(USE_emerge_pkg('sys-process/cronie'))
    call_cmd_and_print_cmd('rc-update add cronie default')

    call_cmd_and_print_cmd(USE_emerge_pkg('sys-apps/mlocate'))
    call_cmd_and_print_cmd(USE_emerge_pkg('sys-fs/e2fsprogs'))
    call_cmd_and_print_cmd(USE_emerge_pkg('net-misc/dhcpcd'))
    call_cmd_and_print_cmd(USE_emerge_pkg('net-wireless/iw'))
    call_cmd_and_print_cmd(USE_emerge_pkg('net-wireless/wpa_supplicant'))

    call_cmd_and_print_cmd('''echo 'GRUB_PLATFORMS="emu efi-32 efi-64 pc"' >> /etc/portage/make.conf''')
    call_cmd_and_print_cmd(USE_emerge_pkg('sys-boot/grub:2'))


    call_cmd_and_print_cmd('''echo 'GRUB_CMDLINE_LINUX="dolvm"' >> /etc/default/grub''')

    call_cmd_and_print_cmd('''grub-install --target=$(lscpu | head -n1 | sed 's/^[^:]*:[[:space:]]*//')-efi --efi-directory=/boot --removable''')
    call_cmd_and_print_cmd('''grub-mkconfig -o /boot/grub/grub.cfg''')

    call_cmd_and_print_cmd(USE_emerge_pkg('sys-boot/os-prober'))


def install_env():
    env_install.env_install()

