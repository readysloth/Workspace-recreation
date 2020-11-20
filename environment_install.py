import sys

from utils import do_with_fallback, source


def env_install():
    do_with_fallback('''echo 'ACCEPT_KEYWORDS="~amd64 amd64 x86"' >> /etc/portage/make.conf''')

    do_with_fallback('mkdir ~/.config')
    do_with_fallback('mkdir ~/env_installation_stages')

    # system
    do_with_fallback('emerge media-fonts/noto')
    do_with_fallback('emerge media-fonts/noto-emoji')

    do_with_fallback('emerge media-libs/libmpd')
    do_with_fallback('emerge acct-user/mpd')

    do_with_fallback('emerge media-sound/alsa-utils')
    do_with_fallback('rc-update add alsasound boot')


    do_with_fallback('USE="gles2" emerge media-sound/mpd')
    do_with_fallback('USE="-abi_x86_32" emerge sys-libs/ncurses')
    do_with_fallback('USE="-abi_x86_32" emerge sys-libs/gpm')
    do_with_fallback('emerge net-wireless/wireless-tools')
    do_with_fallback('emerge app-arch/unrar')

    # dev
    do_with_fallback('emerge dev-vcs/git')
    do_with_fallback('emerge dev-util/cmake')
    do_with_fallback('emerge dev-python/pypy3', 'emerge =dev-python/pypy3-7.3.1-r3')
    do_with_fallback('emerge sys-devel/gdb', 'emerge sys-devel/gdb-9.2')

    do_with_fallback('emerge dev-python/pip', 'emerge =dev-python/pip-20.2.2-r1')

    do_with_fallback('emerge dev-scheme/racket')

    do_with_fallback('emerge dev-python/bpython')
    do_with_fallback('touch ~/env_installation_stages/dev_installed')

    # X11
    do_with_fallback("echo 'x11-base/xorg-server xnest xvfb' >> /etc/portage/package.use/xorg-server")
    do_with_fallback('emerge x11-base/xorg-server')
    do_with_fallback('emerge x11-apps/setxkbmap')
    do_with_fallback('emerge x11-apps/xrandr')
    do_with_fallback('emerge x11-apps/xev')
    do_with_fallback('touch ~/env_installation_stages/xorg_installed')

    # Tiling wm
    do_with_fallback('emerge x11-wm/bspwm')
    do_with_fallback('emerge x11-misc/sxhkd')

    do_with_fallback("echo 'x11-misc/compton xinerama' >> /etc/portage/package.use/compton")
    do_with_fallback('emerge x11-misc/compton')
    do_with_fallback('USE="mpd network pulseaudio curl ipc" emerge x11-misc/polybar', 'emerge x11-misc/polybar')

    do_with_fallback("echo 'x11-misc/dmenu xinerama' >> /etc/portage/package.use/dmenu")
    do_with_fallback('emerge x11-misc/dmenu')
    do_with_fallback('touch ~/env_installation_stages/tiling_installed')

    # Vim plugin manager
    do_with_fallback('curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')

    do_with_fallback('''git clone https://github.com/grwlf/xkb-switch.git;
    pushd xkb-switch;
        mkdir build;
        pushd build;
            cmake ..;
            make -j$(nproc);
            make -j$(nproc) install;
            ldconfig;
        popd;
    popd''')
    do_with_fallback('rm -rf xkb-switch')
    do_with_fallback('touch ~/env_installation_stages/vim_plugin_mg_installed')

    # emulation
    do_with_fallback('emerge app-emulation/docker', 'emerge app-emulation/docker-19.03.12')
    do_with_fallback('rc-update add docker default')
    do_with_fallback('touch ~/env_installation_stages/docker_installed')

    do_with_fallback('emerge app-emulation/qemu', 'emerge app-emulation/qemu-5.1.0-r1')
    do_with_fallback('emerge --autounmask-write app-emulation/virt-manager')
    do_with_fallback('echo -5 | etc-update')

    do_with_fallback('emerge app-emulation/virt-manager', 'emerge app-emulation/virt-manager-2.2.1-r3')
    do_with_fallback('rc-update add libvirtd default')

    do_with_fallback('touch ~/env_installation_stages/qemu_installed')

    do_with_fallback('USE="gles2 -gpm -abi_x86_32" emerge --autounmask-write app-emulation/wine-staging')
    do_with_fallback('echo -5 | etc-update')

    do_with_fallback('USE="gles2 -gpm -abi_x86_32" emerge --backtrack=300 app-emulation/wine-staging',
                     'USE="gles2 -ncurses -abi_x86_32" do_with_fallback --backtrack=300 =app-emulation/wine-staging-5.20',
                     'USE="gles2 -ncurses -abi_x86_32" do_with_fallback --backtrack=300 =app-emulation/wine-staging-5.18')

    do_with_fallback('touch ~/env_installation_stages/wine_staging_installed')

    do_with_fallback('USE="gles2 -gpm -abi_x86_32" emerge app-emulation/wine-mono')

    do_with_fallback('touch ~/env_installation_stages/wine_mono_installed')

    do_with_fallback('USE="gles2 -gpm -abi_x86_32" emerge app-emulation/winetricks')
    do_with_fallback('touch ~/env_installation_stages/winetricks_installed')

    do_with_fallback('USE="gles2 -abi_x86_32" emerge app-emulation/virtualbox', 'emerge =app-emulation/virtualbox-6.0.24')
    do_with_fallback('emerge app-emulation/virtualbox-additions', 'emerge =app-emulation/virtualbox-additions-6.0.24')
        
    do_with_fallback('touch ~/env_installation_stages/virtualbox_installed')

    do_with_fallback('USE="usb" emerge app-emulation/qemu')

    # graphics
    do_with_fallback("echo 'media-gfx/imagemagick djvu jpeg lzma openmp png raw svg webp X zlib' >> /etc/portage/package.use/imagemagick")
    do_with_fallback('emerge media-gfx/imagemagick')
    do_with_fallback('touch ~/env_installation_stages/imagemagick_installed')

    do_with_fallback("echo 'media-gfx/feh xinerama' >> /etc/portage/package.use/feh")
    do_with_fallback('emerge media-gfx/feh')
    do_with_fallback('touch ~/env_installation_stages/feh_installed')

    # rust
    #echo 'dev-lang/rust parallel-compiler' >> /etc/portage/package.use/rust
    do_with_fallback('emerge dev-lang/rust')
    do_with_fallback('touch ~/env_installation_stages/rust_installed')

    # Terminal things
    do_with_fallback('emerge app-shells/bash-completion')

    do_with_fallback('emerge --autounmask-write app-shells/fish')
    do_with_fallback('echo -5 | etc-update')

    do_with_fallback('emerge app-shells/fish')
    do_with_fallback('emerge app-shells/fzf')
    do_with_fallback('emerge app-misc/tmux')
    do_with_fallback('emerge sys-apps/bat')
    do_with_fallback('emerge sys-apps/fd')
    do_with_fallback('emerge sys-apps/ripgrep')
    do_with_fallback('emerge x11-terms/alacritty')
    do_with_fallback('emerge sys-apps/exa')
    do_with_fallback('emerge sys-process/htop')
    do_with_fallback('cargo install ytop')
    do_with_fallback('cargo install procs')

    do_with_fallback('touch ~/env_installation_stages/terminal_things_installed')

    firefox_use = 'pgo pulseaudio'
    do_with_fallback(f'USE="{firefox_use}"emerge www-client/firefox',
                     f'USE=">=media-libs/libvpx-1.9.0 postproc {firefox_use}" emerge www-client/firefox',
                     f'USE=">=media-libs/libvpx-1.9.0 postproc {firefox_use}" emerge =www-client/firefox-78.4.1')

    do_with_fallback('touch ~/env_installation_stages/firefox_installed')

    # office
    do_with_fallback('emerge net-fs/samba')
    do_with_fallback('emerge net-fs/cifs-utils')

    do_with_fallback('USE="-gpm -abi_x86_32" emerge --autounmask-write app-office/libreoffice')
    do_with_fallback('echo -5 | etc-update')
    do_with_fallback('USE="-gpm -abi_x86_32" emerge app-office/libreoffice')
        

    do_with_fallback('touch ~/env_installation_stages/office_installed')

    # misc
    do_with_fallback('emerge app-admin/sudo')
    do_with_fallback('emerge x11-apps/xkill')
    do_with_fallback('emerge x11-misc/rofi')

    do_with_fallback('touch ~/env_installation_stages/misc_installed')

    do_with_fallback('./create_configs.sh')
