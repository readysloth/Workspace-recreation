import sys

from utils import do_with_fallback, source, USE_emerge_pkg


def env_install():
    do_with_fallback('''echo 'ACCEPT_KEYWORDS="~amd64 amd64 x86"' >> /etc/portage/make.conf''')

    do_with_fallback('mkdir ~/.config')
    do_with_fallback('mkdir ~/env_installation_stages')

    # system
    do_with_fallback(USE_emerge_pkg('media-fonts/noto'))
    do_with_fallback(USE_emerge_pkg('media-fonts/noto-emoji'))

    do_with_fallback(USE_emerge_pkg('x11-apps/xbacklight'))


    do_with_fallback(USE_emerge_pkg('media-sound/alsa-utils'))
    do_with_fallback('rc-update add alsasound boot')


    do_with_fallback(USE_emerge_pkg('media-sound/pulseaudio',  'alsa', 'alsa-plugin', 'bluetooth', 'daemon', 'udev', 'system-wide'))
    do_with_fallback(USE_emerge_pkg('media-sound/pulsemixer'))


    do_with_fallback(USE_emerge_pkg('media-libs/libmpd'))
    do_with_fallback(USE_emerge_pkg('acct-user/mpd'))
    do_with_fallback(USE_emerge_pkg('media-sound/mpd'))
    do_with_fallback(USE_emerge_pkg('sys-libs/gpm'))
    do_with_fallback(USE_emerge_pkg('net-wireless/wireless-tools'))
    do_with_fallback(USE_emerge_pkg('app-arch/unrar'))

    do_with_fallback(USE_emerge_pkg('sys-fs/mtools'))
    do_with_fallback(USE_emerge_pkg('sys-fs/ncdu'))

    # dev
    do_with_fallback(USE_emerge_pkg('dev-vcs/git'))
    do_with_fallback(USE_emerge_pkg('dev-util/cmake'))
    do_with_fallback(USE_emerge_pkg('dev-python/pypy3', 'emerge =dev-python/pypy3-7.3.1-r3'))
    do_with_fallback(USE_emerge_pkg('sys-devel/gdb', 'emerge sys-devel/gdb-10.2'))

    do_with_fallback(USE_emerge_pkg('dev-python/pip', 'emerge =dev-python/pip-20.2.2-r1'))

    do_with_fallback(USE_emerge_pkg('dev-scheme/racket'))
    do_with_fallback(USE_emerge_pkg('dev-lang/clojure'))

    do_with_fallback(USE_emerge_pkg('dev-python/bpython'))
    do_with_fallback('touch ~/env_installation_stages/dev_installed')

    # X11
    do_with_fallback(USE_emerge_pkg('x11-base/xorg-server', 'xnest', 'xvfb'))
    do_with_fallback(USE_emerge_pkg('x11-apps/setxkbmap'))
    do_with_fallback(USE_emerge_pkg('x11-apps/xrandr'))
    do_with_fallback(USE_emerge_pkg('x11-apps/xev'))
    do_with_fallback(USE_emerge_pkg('media-gfx/scrot'))
    do_with_fallback(USE_emerge_pkg('x11-misc/clipmenu'))
    do_with_fallback(USE_emerge_pkg('media-gfx/flameshot'))
    do_with_fallback('touch ~/env_installation_stages/xorg_installed')

    # Tiling wm
    do_with_fallback(USE_emerge_pkg('x11-wm/bspwm'))
    do_with_fallback(USE_emerge_pkg('x11-misc/sxhkd'))

    do_with_fallback(USE_emerge_pkg('x11-misc/compton', 'xinerama'))
    do_with_fallback(USE_emerge_pkg('x11-misc/polybar', 'mpd', 'network', 'pulseaudio', 'curl', 'ipc'))

    do_with_fallback(USE_emerge_pkg('x11-misc/dmenu', 'xinerama'))
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
    do_with_fallback(USE_emerge_pkg('app-emulation/docker'))
    do_with_fallback('rc-update add docker default')
    do_with_fallback('touch ~/env_installation_stages/docker_installed')

    do_with_fallback(USE_emerge_pkg('app-emulation/qemu',
                                    'aio',
                                    'alsa',
                                    'capstone',
                                    'curl',
                                    'fdt',
                                    'io-uring'
                                    'plugins',
                                    'png',
                                    'pulseaudio',
                                    'sdl',
                                    'sdl-image',
                                    'spice',
                                    'ssh',
                                    'usb',
                                    'usbredir',
                                    'gtk',
                                    'vnc',
                                    'python'))
    do_with_fallback(USE_emerge_pkg('app-emulation/virt-manager'))

    do_with_fallback('rc-update add libvirtd default')

    do_with_fallback('touch ~/env_installation_stages/qemu_installed')

    do_with_fallback(USE_emerge_pkg('app-emulation/wine-staging',
                                    '-gpm',
                                    'dos',
                                    'faudio',
                                    'gecko',
                                    'mono',
                                    'opencl',
                                    'udev',
                                    'run-exes',
                                    'samba',
                                    'sdl',
                                    'vulkan',
                                    'vk3d'))

    do_with_fallback('touch ~/env_installation_stages/wine_staging_installed')

    do_with_fallback(USE_emerge_pkg('app-emulation/wine-mono'))

    do_with_fallback('touch ~/env_installation_stages/wine_mono_installed')

    do_with_fallback(USE_emerge_pkg('app-emulation/winetricks'))
    do_with_fallback('touch ~/env_installation_stages/winetricks_installed')

    do_with_fallback(USE_emerge_pkg('app-emulation/virtualbox'))
    do_with_fallback(USE_emerge_pkg('app-emulation/virtualbox-additions'))

    do_with_fallback('touch ~/env_installation_stages/virtualbox_installed')

    do_with_fallback('USE="usb" emerge app-emulation/qemu')

    # graphics
    do_with_fallback(USE_emerge_pkg('media-gfx/imagemagick', 'djvu',
                                    'jpeg',
                                    'lzma',
                                    'openmp',
                                    'png',
                                    'raw',
                                    'svg',
                                    'webp',
                                    'X',
                                    'zlib'))
    do_with_fallback('touch ~/env_installation_stages/imagemagick_installed')

    do_with_fallback(USE_emerge_pkg('media-gfx/feh', 'xinerama'))
    do_with_fallback('touch ~/env_installation_stages/feh_installed')

    # rust
    #echo 'dev-lang/rust parallel-compiler' >> /etc/portage/package.use/rust
    do_with_fallback(USE_emerge_pkg('dev-lang/rust'))
    do_with_fallback('touch ~/env_installation_stages/rust_installed')

    # Terminal things
    do_with_fallback(USE_emerge_pkg('app-shells/bash-completion'))

    do_with_fallback(USE_emerge_pkg('app-shells/fish'))

    do_with_fallback(USE_emerge_pkg('app-shells/fzf'))
    do_with_fallback(USE_emerge_pkg('app-misc/tmux'))
    do_with_fallback(USE_emerge_pkg('sys-apps/bat'))
    do_with_fallback(USE_emerge_pkg('sys-apps/fd'))
    do_with_fallback(USE_emerge_pkg('sys-apps/ripgrep'))
    do_with_fallback(USE_emerge_pkg('x11-terms/alacritty'))
    do_with_fallback(USE_emerge_pkg('sys-apps/exa'))
    do_with_fallback(USE_emerge_pkg('sys-process/htop'))
    do_with_fallback('cargo install ytop')
    do_with_fallback('cargo install procs')

    do_with_fallback('touch ~/env_installation_stages/terminal_things_installed')

    do_with_fallback(USE_emerge_pkg('www-client/firefox', '-gpm' 'lto', 'pgo', 'pulseaudio', 'geckodriver'))

    do_with_fallback('touch ~/env_installation_stages/firefox_installed')

    # office
    do_with_fallback(USE_emerge_pkg('net-fs/samba'))
    do_with_fallback(USE_emerge_pkg('net-fs/cifs-utils'))

    do_with_fallback(USE_emerge_pkg('app-office/libreoffice', '-gpm'))

    do_with_fallback('touch ~/env_installation_stages/office_installed')

    # misc
    do_with_fallback(USE_emerge_pkg('net-im/telegram-desktop'))
    do_with_fallback(USE_emerge_pkg('x11-apps/xkill'))
    do_with_fallback(USE_emerge_pkg('x11-misc/rofi'))

    do_with_fallback('touch ~/env_installation_stages/misc_installed')

    do_with_fallback('./create_configs.sh')
