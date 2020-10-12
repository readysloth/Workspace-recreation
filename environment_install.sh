
install_with_fallback(){
    set +o errexit
        preferred_package="$1"
        fallback_package="=$2"
        emerge "$preferred_package"
        ret=$?
        [ $ret -ne 0 ] && emerge "$fallback_package"

    set -o errexit
}

set -o errexit

echo 'ACCEPT_KEYWORDS="amd x86"' >> /etc/portage/make.conf

mkdir ~/.config
mkdir ~/env_installation_stages

# dev
emerge dev-vcs/git
emerge dev-util/cmake
install_with_fallback "sys-devel/gdb" "sys-devel/gdb-9.2"
emerge dev-python/bpython
echo -5 | etc-update
touch ~/env_installation_stages/dev_installed

# X11
echo 'x11-base/xorg-server xnest xvfb' >> /etc/portage/package.use/xorg-server
emerge x11-base/xorg-server
echo -5 | etc-update
touch ~/env_installation_stages/xorg_installed

# Tiling wm
emerge x11-wm/bspwm
emerge x11-misc/sxhkd
echo -5 | etc-update

echo 'x11-misc/compton xinerama' >> /etc/portage/package.use/compton
emerge x11-misc/compton
emerge x11-misc/polybar

echo 'x11-misc/dmenu xinerama' >> /etc/portage/package.use/dmenu
emerge x11-misc/dmenu
echo -5 | etc-update
touch ~/env_installation_stages/tiling_installed

# Vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/grwlf/xkb-switch.git
pushd xkb-switch
    mkdir build
    pushd build
        cmake ..
        make -j$(nproc)
        make -j$(nproc) install
        ldconfig
    popd
popd
rm -rf xkb-switch
echo -5 | etc-update
touch ~/env_installation_stages/vim_plugin_mg_installed

# emulation
install_with_fallback "app-emulation/docker" "app-emulation/docker-19.03.12"
rc-update add docker default
touch ~/env_installation_stages/docker_installed

install_with_fallback "app-emulation/qemu" "app-emulation/qemu-5.1.0-r1"
touch ~/env_installation_stages/qemu_installed

set +o errexit
emerge --autounmask-write app-emulation/wine-staging
echo -5 | etc-update
set -o errexit

emerge app-emulation/wine-staging
touch ~/env_installation_stages/wine_staging_installed
emerge app-emulation/wine-mono
touch ~/env_installation_stages/wine_mono_installed
emerge app-emulation/winetricks
touch ~/env_installation_stages/winetricks_installed

emerge app-emulation/virtualbox
echo -5 | etc-update
touch ~/env_installation_stages/virtualbox_installed

# graphics
echo 'media-gfx/imagemagick djvu jpeg lzma openmp png raw svg webp X zlib' >> /etc/portage/package.use/imagemagick
emerge media-gfx/imagemagick
touch ~/env_installation_stages/imagemagick_installed

echo 'media-gfx/feh xinerama' >> /etc/portage/package.use/feh
emerge media-gfx/feh
echo -5 | etc-update
touch ~/env_installation_stages/feh_installed

# rust
echo 'dev-lang/rust parallel-compiler' >> /etc/portage/package.use/rust
emerge dev-lang/rust
echo -5 | etc-update
touch ~/env_installation_stages/rust_installed

# Terminal things
emerge app-shells/bash-completion
emerge app-shells/fzf
emerge app-misc/tmux
emerge sys-apps/bat
emerge sys-apps/fd
emerge sys-apps/ripgrep
emerge x11-terms/alacritty
emerge x11-terms/cool-retro-term
emerge sys-apps/exa
emerge sys-process/htop
echo -5 | etc-update
cargo install ytop
cargo install procs

touch ~/env_installation_stages/terminal_things_installed

# librewolf
echo '[librewolf]'                                                          >> /etc/portage/repos.conf/librewolf.conf
echo 'priority = 50'                                                        >> /etc/portage/repos.conf/librewolf.conf
echo 'location = /etc/librewolf'                                            >> /etc/portage/repos.conf/librewolf.conf
echo 'sync-type = git'                                                      >> /etc/portage/repos.conf/librewolf.conf
echo 'sync-uri = https://gitlab.com/librewolf-community/browser/gentoo.git' >> /etc/portage/repos.conf/librewolf.conf
echo 'auto-sync = Yes'                                                      >> /etc/portage/repos.conf/librewolf.conf
emaint -r librewolf sync
USE="postproc" emerge librewolf
echo -5 | etc-update

touch ~/env_installation_stages/librewolf_installed

# office
emerge net-fs/samba
emerge app-office/libreoffice

echo -5 | etc-update
touch ~/env_installation_stages/office_installed

# misc
emerge app-admin/sudo
emerge x11-apps/xkill
emerge x11-misc/rofi

git clone https://github.com/cmauri/eviacam.git 
pushd eviacam
    ./autogen.sh
    ./configure
    make -j$(nproc)
    make install
popd
touch ~/env_installation_stages/misc_installed


RECREATION_DIR="$(mktemp -d)"
git clone https://github.com/readysloth/Workspace-recreation.git "$RECREATION_DIR"

./create_configs.sh "$RECREATION_DIR"
