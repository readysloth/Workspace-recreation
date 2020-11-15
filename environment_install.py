import sys

from utils import call_cmd_and_print_cmd, source


def env_install():
    call_cmd_and_print_cmd('''echo 'ACCEPT_KEYWORDS="~amd64 amd64 x86"' >> /etc/portage/make.conf''')

    call_cmd_and_print_cmd('mkdir ~/.config')
    call_cmd_and_print_cmd('mkdir ~/env_installation_stages')

    # system
    call_cmd_and_print_cmd('emerge media-libs/libmpd')
    call_cmd_and_print_cmd('emerge media-sound/alsa-utils')
    call_cmd_and_print_cmd('USE="gles2" emerge media-sound/mpd')
    call_cmd_and_print_cmd('USE="-abi_x86_32" emerge sys-libs/ncurses')
    call_cmd_and_print_cmd('USE="-abi_x86_32" emerge sys-libs/gpm')
    call_cmd_and_print_cmd('emerge net-wireless/wireless-tools')
    call_cmd_and_print_cmd('emerge app-arch/unrar')

    # dev
    call_cmd_and_print_cmd('emerge dev-vcs/git')
    call_cmd_and_print_cmd('emerge dev-util/cmake')
    call_cmd_and_print_cmd('emerge dev-python/pypy')
    try:
        call_cmd_and_print_cmd('emerge sys-devel/gdb')
    except Exception as e:
        call_cmd_and_print_cmd('emerge sys-devel/gdb-9.2')

    try:
        call_cmd_and_print_cmd('emerge dev-scheme/racket')
    except Exception as e:
        pass

    call_cmd_and_print_cmd('emerge dev-python/bpython')
    call_cmd_and_print_cmd('touch ~/env_installation_stages/dev_installed')

    # X11
    call_cmd_and_print_cmd("echo 'x11-base/xorg-server xnest xvfb' >> /etc/portage/package.use/xorg-server")
    call_cmd_and_print_cmd('emerge x11-base/xorg-server')
    call_cmd_and_print_cmd('emerge x11-apps/setxkbmap')
    call_cmd_and_print_cmd('emerge x11-apps/xev')
    call_cmd_and_print_cmd('touch ~/env_installation_stages/xorg_installed')

    # Tiling wm
    call_cmd_and_print_cmd('emerge x11-wm/bspwm')
    call_cmd_and_print_cmd('emerge x11-misc/sxhkd')

    call_cmd_and_print_cmd("echo 'x11-misc/compton xinerama' >> /etc/portage/package.use/compton")
    call_cmd_and_print_cmd('emerge x11-misc/compton')
    call_cmd_and_print_cmd('emerge x11-misc/polybar')

    call_cmd_and_print_cmd("echo 'x11-misc/dmenu xinerama' >> /etc/portage/package.use/dmenu")
    call_cmd_and_print_cmd('emerge x11-misc/dmenu')
    call_cmd_and_print_cmd('touch ~/env_installation_stages/tiling_installed')

    # Vim plugin manager
    call_cmd_and_print_cmd('curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')

    call_cmd_and_print_cmd('''git clone https://github.com/grwlf/xkb-switch.git;
    pushd xkb-switch;
        mkdir build;
        pushd build;
            cmake ..;
            make -j$(nproc);
            make -j$(nproc) install;
            ldconfig;
        popd;
    popd''')
    call_cmd_and_print_cmd('rm -rf xkb-switch')
    call_cmd_and_print_cmd('touch ~/env_installation_stages/vim_plugin_mg_installed')

    # emulation
    try:
        call_cmd_and_print_cmd('emerge app-emulation/docker')
    except Exception as e:
        call_cmd_and_print_cmd('emerge app-emulation/docker-19.03.12')
    call_cmd_and_print_cmd('rc-update add docker default')
    call_cmd_and_print_cmd('touch ~/env_installation_stages/docker_installed')

    try:
        call_cmd_and_print_cmd('emerge app-emulation/qemu')
    except Exception as e:
        call_cmd_and_print_cmd('emerge app-emulation/qemu-5.1.0-r1')
    try:
        call_cmd_and_print_cmd('emerge --autounmask-write app-emulation/virt-manager')
    except Exception as e:
        pass

    call_cmd_and_print_cmd('echo -5 | etc-update')
    try:
        call_cmd_and_print_cmd('emerge app-emulation/virt-manager')
    except Exception as e:
        try:
            call_cmd_and_print_cmd('emerge app-emulation/virt-manager-2.2.1-r3')
        except Exception as e:
            pass

    call_cmd_and_print_cmd('touch ~/env_installation_stages/qemu_installed')

    try:
        call_cmd_and_print_cmd('USE="gles2 -gpm -abi_x86_32" emerge --autounmask-write app-emulation/wine-staging')
    except Exception as e:
        pass
    call_cmd_and_print_cmd('echo -5 | etc-update')

    try:
        call_cmd_and_print_cmd('USE="gles2 -gpm -abi_x86_32" emerge --backtrack=300 app-emulation/wine-staging')
    except Exception as e:
        try:
            call_cmd_and_print_cmd('USE="gles2 -ncurses -abi_x86_32" emerge --backtrack=300 =app-emulation/wine-staging-5.20')
        except Exception as e:
            call_cmd_and_print_cmd('USE="gles2 -ncurses -abi_x86_32" emerge --backtrack=300 =app-emulation/wine-staging-5.18')

    call_cmd_and_print_cmd('touch ~/env_installation_stages/wine_staging_installed')
    try:
        call_cmd_and_print_cmd('USE="gles2 -gpm -abi_x86_32" emerge app-emulation/wine-mono')
    except Exception as e:
        pass
    call_cmd_and_print_cmd('touch ~/env_installation_stages/wine_mono_installed')
    try:
        call_cmd_and_print_cmd('USE="gles2 -gpm -abi_x86_32" emerge app-emulation/winetricks')
    except Exception as e:
        pass
    call_cmd_and_print_cmd('touch ~/env_installation_stages/winetricks_installed')

    try:
        call_cmd_and_print_cmd('USE="gles2 -abi_x86_32" emerge app-emulation/virtualbox')
        call_cmd_and_print_cmd('emerge app-emulation/virtualbox-additions')
    except Exception as e:
        try:
            call_cmd_and_print_cmd('emerge =app-emulation/virtualbox-6.0.24')
            call_cmd_and_print_cmd('emerge =app-emulation/virtualbox-additions-6.0.24')
        except Exception as e:
            pass
        
    call_cmd_and_print_cmd('touch ~/env_installation_stages/virtualbox_installed')
    call_cmd_and_print_cmd('USE="usb" emerge app-emulation/qemu')

    # graphics
    call_cmd_and_print_cmd("echo 'media-gfx/imagemagick djvu jpeg lzma openmp png raw svg webp X zlib' >> /etc/portage/package.use/imagemagick")
    call_cmd_and_print_cmd('emerge media-gfx/imagemagick')
    call_cmd_and_print_cmd('touch ~/env_installation_stages/imagemagick_installed')

    call_cmd_and_print_cmd("echo 'media-gfx/feh xinerama' >> /etc/portage/package.use/feh")
    call_cmd_and_print_cmd('emerge media-gfx/feh')
    call_cmd_and_print_cmd('touch ~/env_installation_stages/feh_installed')

    # rust
    #echo 'dev-lang/rust parallel-compiler' >> /etc/portage/package.use/rust
    call_cmd_and_print_cmd('emerge dev-lang/rust')
    call_cmd_and_print_cmd('touch ~/env_installation_stages/rust_installed')

    # Terminal things
    call_cmd_and_print_cmd('emerge app-shells/bash-completion')
    try:
        call_cmd_and_print_cmd('emerge --autounmask-write app-shells/fish')
    except Exception as e:
        call_cmd_and_print_cmd('echo -5 | etc-update')
        pass
    call_cmd_and_print_cmd('emerge app-shells/fish')
    call_cmd_and_print_cmd('emerge app-shells/fzf')
    call_cmd_and_print_cmd('emerge app-misc/tmux')
    call_cmd_and_print_cmd('emerge sys-apps/bat')
    call_cmd_and_print_cmd('emerge sys-apps/fd')
    call_cmd_and_print_cmd('emerge sys-apps/ripgrep')
    call_cmd_and_print_cmd('emerge x11-terms/alacritty')
    call_cmd_and_print_cmd('emerge sys-apps/exa')
    call_cmd_and_print_cmd('emerge sys-process/htop')
    call_cmd_and_print_cmd('cargo install ytop')
    call_cmd_and_print_cmd('cargo install procs')

    call_cmd_and_print_cmd('touch ~/env_installation_stages/terminal_things_installed')

    try:
        call_cmd_and_print_cmd('emerge www-client/firefox')
    except Exception as e:
        call_cmd_and_print_cmd('USE=">=media-libs/libvpx-1.9.0 postproc" emerge www-client/firefox')

    call_cmd_and_print_cmd('touch ~/env_installation_stages/firefox_installed')

    # office
    call_cmd_and_print_cmd('emerge net-fs/samba')
    call_cmd_and_print_cmd('emerge net-fs/cifs-utils')
    try:
        call_cmd_and_print_cmd('USE="-gpm -abi_x86_32" emerge --autounmask-write app-office/libreoffice')
    except Exception as e:
        call_cmd_and_print_cmd('echo -5 | etc-update')
    call_cmd_and_print_cmd('USE="-gpm -abi_x86_32" emerge app-office/libreoffice')
        

    call_cmd_and_print_cmd('touch ~/env_installation_stages/office_installed')

    # misc
    call_cmd_and_print_cmd('emerge app-admin/sudo')
    call_cmd_and_print_cmd('emerge x11-apps/xkill')
    call_cmd_and_print_cmd('emerge x11-misc/rofi')

    call_cmd_and_print_cmd('touch ~/env_installation_stages/misc_installed')

    call_cmd_and_print_cmd('./create_configs.sh')
