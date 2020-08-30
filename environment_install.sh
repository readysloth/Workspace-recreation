
mkdir ~/.config

# Terminal things
emerge app-shells/bash-completion
emerge app-misc/tmux

# dev
emerge dev-vcs/git
emerge dev-util/cmake

# X11
emerge x11-base/xorg-server

# Tiling wm
emerge x11-wm/bspwm
emerge x11-misc/sxhkd
emerge x11-misc/compton
emerge x11-misc/polybar
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
emerge media-gfx/imagemagick
emerge media-gfx/feh

# rust
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
