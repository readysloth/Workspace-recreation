
mkdir ~/.config

# Terminal things
emerge app-shells/bash-completion
emerge app-shells/fzf
emerge app-misc/tmux

# dev
emerge dev-vcs/git
emerge dev-util/cmake

# X11
echo 'x11-base/xorg-server xnest xvfb' >> /etc/portage/package.use/xorg-server
emerge x11-base/xorg-server

# Tiling wm
emerge x11-wm/bspwm
emerge x11-misc/sxhkd

echo 'x11-misc/compton xinerama' >> /etc/portage/package.use/compton
emerge x11-misc/compton
emerge x11-misc/polybar

echo 'x11-misc/dmenu xinerama' >> /etc/portage/package.use/dmenu
emerge x11-misc/dmenu

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


# terminal
st.sh download
st.sh download_misc
st.sh install_misc
st.sh install


# graphics
echo 'media-gfx/imagemagick djvu jpeg lzma openmp png raw svg webp X zlib' >> /etc/portage/package.use/imagemagick
emerge media-gfx/imagemagick

echo 'media-gfx/feh xinerama' >> /etc/portage/package.use/feh
emerge media-gfx/feh

# rust
echo 'dev-lang/rust parallel-compiler' >> /etc/portage/package.use/rust
emerge dev-lang/rust

# librewolf
echo '[librewolf]'                                                          >> /etc/portage/repos.conf/librewolf.conf
echo 'priority = 50'                                                        >> /etc/portage/repos.conf/librewolf.conf
echo 'location = /etc/librewolf'                                            >> /etc/portage/repos.conf/librewolf.conf
echo 'sync-type = git'                                                      >> /etc/portage/repos.conf/librewolf.conf
echo 'sync-uri = https://gitlab.com/librewolf-community/browser/gentoo.git' >> /etc/portage/repos.conf/librewolf.conf
echo 'auto-sync = Yes'                                                      >> /etc/portage/repos.conf/librewolf.conf
emaint -r librewolf sync
emerge librewolf


./configs.sh
