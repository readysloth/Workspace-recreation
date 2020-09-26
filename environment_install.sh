
mkdir ~/.config

# dev
emerge dev-vcs/git
emerge dev-util/cmake
emerge sys-devel/gdb
emerge dev-python/bpython
echo -5 | etc-update

# X11
echo 'x11-base/xorg-server xnest xvfb' >> /etc/portage/package.use/xorg-server
emerge x11-base/xorg-server
echo -5 | etc-update

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

# emulation
emerge app-emulation/docker
rc-update add docker default

emerge app-emulation/qemu

emerge app-emulation/wine-staging
emerge app-emulation/wine-mono
emerge app-emulation/winetricks

emerge app-emulation/virtualbox
echo -5 | etc-update

# graphics
echo 'media-gfx/imagemagick djvu jpeg lzma openmp png raw svg webp X zlib' >> /etc/portage/package.use/imagemagick
emerge media-gfx/imagemagick

echo 'media-gfx/feh xinerama' >> /etc/portage/package.use/feh
emerge media-gfx/feh
echo -5 | etc-update

# rust
echo 'dev-lang/rust parallel-compiler' >> /etc/portage/package.use/rust
emerge dev-lang/rust
echo -5 | etc-update

# Terminal things
emerge app-shells/bash-completion
emerge app-shells/fzf
emerge app-misc/tmux
emerge sys-apps/bat
emerge sys-apps/fd
emerge sys-apps/ripgrep
emerge x11-terms/alacritty
emerge sys-apps/exa
emerge sys-process/htop
echo -5 | etc-update
cargo install ytop
cargo install procs

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

# office
emerge net-fs/samba
emerge app-office/libreoffice

echo -5 | etc-update

# misc
emerge app-admin/sudo


RECREATION_DIR="$(mktemp -d)"
git clone https://github.com/readysloth/Workspace-recreation.git "$RECREATION_DIR"

./configs.sh "$RECREATION_DIR"
