
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

# Vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# graphics
emerge media-gfx/imagemagick

./configs.sh
