
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

# vimb
emerge x11-libs/gtk+
emerge net-libs/webkit-gtk
git clone https://github.com/fanglingsu/vimb.git
pushd vimb
    make -j$(nproc) PREFIX=/usr
    make -j$(nproc) PREFIX=/usr install
popd 
rm -rf vimb




./configs.sh
