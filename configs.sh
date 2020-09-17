# I'm aware about heredocuments, but don't like them

# bashrc
echo "bind 'set completion-ignore-case on'"  > ~/.bashrc
echo 'export EDITOR=vim'                    >> ~/.bashrc
echo 'alias ls=exa'                         >> ~/.bashrc
echo 'alias l=exa'                          >> ~/.bashrc
echo 'alias cat=bat'                        >> ~/.bashrc
echo 'export PATH=$PATH:~/.cargo/bin'       >> ~/.bashrc

# Xinit
echo 'sxhkd &'     > ~/.xinitrc
echo 'exec bspwm' >> ~/.xinitrc

# Vim
echo 'set number'          > ~/.vimrc
echo 'set relativenumber' >> ~/.vimrc
echo                      >> ~/.vimrc
echo 'set hlsearch'       >> ~/.vimrc
echo 'set incsearch'      >> ~/.vimrc
echo                      >> ~/.vimrc
echo 'set wildmenu'       >> ~/.vimrc
echo 'set nocompatible'   >> ~/.vimrc
echo                      >> ~/.vimrc
echo 'set tabstop=8'      >> ~/.vimrc
echo 'set softtabstop=0'  >> ~/.vimrc
echo 'set expandtab'      >> ~/.vimrc
echo 'set shiftwidth=4'   >> ~/.vimrc
echo 'set smarttab'       >> ~/.vimrc
echo                      >> ~/.vimrc
echo 'syntax on'          >> ~/.vimrc
echo                      >> ~/.vimrc

echo "call plug#begin('~/.vim/plugged')"      >> ~/.vimrc
echo                                          >> ~/.vimrc
echo "Plug 'easymotion/vim-easymotion'"       >> ~/.vimrc
echo "Plug 'godlygeek/tabular'"               >> ~/.vimrc
echo "Plug 'luochen1990/rainbow'"             >> ~/.vimrc
echo "Plug 'mbbill/undotree'"                 >> ~/.vimrc
echo "Plug 'mkitt/tabline.vim'"               >> ~/.vimrc
echo "Plug 'nathanaelkane/vim-indent-guides'" >> ~/.vimrc
echo "Plug 'scrooloose/nerdtree'"             >> ~/.vimrc
echo "Plug 'sheerun/vim-polyglot'"            >> ~/.vimrc
echo "Plug 'tpope/vim-fugitive'"              >> ~/.vimrc
echo "Plug 'tpope/vim-surround'"              >> ~/.vimrc
echo "Plug 'chrisbra/csv.vim'"                >> ~/.vimrc
echo "Plug 'lyokha/vim-xkbswitch'"            >> ~/.vimrc
echo "Plug 'kovetskiy/sxhkd-vim'"             >> ~/.vimrc
echo "Plug 'tpope/vim-repeat'"                >> ~/.vimrc
echo "Plug 'junegunn/fzf.vim'"                >> ~/.vimrc
echo "Plug 'blueyed/vim-diminactive'"         >> ~/.vimrc
echo                                          >> ~/.vimrc
echo "call plug#end()"                        >> ~/.vimrc
echo                                          >> ~/.vimrc
echo 'map <C-n> :NERDTreeToggle<CR>'                 >> ~/.vimrc
echo 'map U :UndotreeToggle<CR>'                     >> ~/.vimrc
echo 'map gG :G<CR>'                                 >> ~/.vimrc
echo                                                 >> ~/.vimrc
echo 'let g:indent_guides_enable_on_vim_startup = 1' >> ~/.vimrc
echo 'let g:XkbSwitchEnabled = 1'                    >> ~/.vimrc
echo 'let g:diminactive_use_syntax = 1'              >> ~/.vimrc
echo                                                 >> ~/.vimrc
echo 'autocmd VimEnter * DimInactiveOn'              >> ~/.vimrc

vim +PlugInstall +qa


# tmux
echo 'set -g prefix C-a'                                       > ~/.tmux.conf
echo 'bind C-a send-prefix'                                   >> ~/.tmux.conf
echo 'unbind C-b'                                             >> ~/.tmux.conf
echo 'set -sg escape-time 1'                                  >> ~/.tmux.conf
echo 'set -g base-index 1'                                    >> ~/.tmux.conf
echo 'setw -g pane-base-index 1'                              >> ~/.tmux.conf
echo 'setw -g repeat-time 1000'                               >> ~/.tmux.conf
echo 'bind r source-file ~/.tmux.conf \; display "Reloaded!"' >> ~/.tmux.conf
echo                                                          >> ~/.tmux.conf
echo 'bind | split-window -h -c "#{pane_current_path}"'       >> ~/.tmux.conf
echo 'bind - split-window -v -c "#{pane_current_path}"'       >> ~/.tmux.conf
echo 'bind c new-window -c      "#{pane_current_path}"'       >> ~/.tmux.conf
echo                                                          >> ~/.tmux.conf
echo 'bind h select-pane -L'                                  >> ~/.tmux.conf
echo 'bind j select-pane -D'                                  >> ~/.tmux.conf
echo 'bind k select-pane -U'                                  >> ~/.tmux.conf
echo 'bind l select-pane -R'                                  >> ~/.tmux.conf
echo                                                          >> ~/.tmux.conf
echo 'bind -r C-h select-window -t :-'                        >> ~/.tmux.conf
echo 'bind -r C-l select-window -t :+'                        >> ~/.tmux.conf
echo                                                          >> ~/.tmux.conf
echo 'bind -r H resize-pane -L 5'                             >> ~/.tmux.conf
echo 'bind -r J resize-pane -D 5'                             >> ~/.tmux.conf
echo 'bind -r K resize-pane -U 5'                             >> ~/.tmux.conf
echo 'bind -r L resize-pane -R 5'                             >> ~/.tmux.conf
echo                                                          >> ~/.tmux.conf
echo 'set -g default-terminal "screen-256color"'              >> ~/.tmux.conf


# alacritty
mkdir ~/.config/alacritty
pushd ~/.config/alacritty
    wget https://github.com/alacritty/alacritty/releases/download/v0.5.0/alacritty.yml
    sed -i  -e 's/#env:/env:/' \
            -e 's/#TERM:/TERM:/' \
            -e 's/#window:/window:/' \
            -e 's/#decorations:.*/decorations: none/' alacritty.yml

    # theme
    echo "# Colors (Hyper)"           >> alacritty.yml
    echo "colors:"                    >> alacritty.yml
    echo "  # Default colors"         >> alacritty.yml
    echo "  primary:"                 >> alacritty.yml
    echo "    background: '0x000000'" >> alacritty.yml
    echo "    foreground: '0xffffff'" >> alacritty.yml
    echo "  cursor:"                  >> alacritty.yml
    echo "    text: '0xF81CE5'"       >> alacritty.yml
    echo "    cursor: '0xffffff'"     >> alacritty.yml
    echo ""                           >> alacritty.yml
    echo "  # Normal colors"          >> alacritty.yml
    echo "  normal:"                  >> alacritty.yml
    echo "    black:   '0x000000'"    >> alacritty.yml
    echo "    red:     '0xfe0100'"    >> alacritty.yml
    echo "    green:   '0x33ff00'"    >> alacritty.yml
    echo "    yellow:  '0xfeff00'"    >> alacritty.yml
    echo "    blue:    '0x0066ff'"    >> alacritty.yml
    echo "    magenta: '0xcc00ff'"    >> alacritty.yml
    echo "    cyan:    '0x00ffff'"    >> alacritty.yml
    echo "    white:   '0xd0d0d0'"    >> alacritty.yml
    echo ""                           >> alacritty.yml
    echo "  # Bright colors"          >> alacritty.yml
    echo "  bright:"                  >> alacritty.yml
    echo "    black:   '0x808080'"    >> alacritty.yml
    echo "    red:     '0xfe0100'"    >> alacritty.yml
    echo "    green:   '0x33ff00'"    >> alacritty.yml
    echo "    yellow:  '0xfeff00'"    >> alacritty.yml
    echo "    blue:    '0x0066ff'"    >> alacritty.yml
    echo "    magenta: '0xcc00ff'"    >> alacritty.yml
    echo "    cyan:    '0x00ffff'"    >> alacritty.yml
    echo "    white:   '0xFFFFFF'"    >> alacritty.yml
popd

# polybar
mkdir ~/.config/polybar
touch ~/.config/polybar/config
echo '[colors]'                          >> ~/.config/polybar/config
echo 'background = #000000'              >> ~/.config/polybar/config
echo 'foreground = #ffffff'              >> ~/.config/polybar/config
echo ''                                  >> ~/.config/polybar/config
echo '[module/cpu]'                      >> ~/.config/polybar/config
echo 'type = internal/cpu'               >> ~/.config/polybar/config
echo 'format = <label> <ramp-coreload>'  >> ~/.config/polybar/config
echo 'label = CPU %percentage%%'         >> ~/.config/polybar/config
echo 'ramp-coreload-spacing = 1'         >> ~/.config/polybar/config
echo 'ramp-coreload-0 = ▁'               >> ~/.config/polybar/config
echo 'ramp-coreload-1 = ▂'               >> ~/.config/polybar/config
echo 'ramp-coreload-2 = ▃'               >> ~/.config/polybar/config
echo 'ramp-coreload-3 = ▄'               >> ~/.config/polybar/config
echo 'ramp-coreload-4 = ▅'               >> ~/.config/polybar/config
echo 'ramp-coreload-5 = ▆'               >> ~/.config/polybar/config
echo 'ramp-coreload-6 = ▇'               >> ~/.config/polybar/config
echo 'ramp-coreload-7 = █'               >> ~/.config/polybar/config
echo ''                                  >> ~/.config/polybar/config
echo '[module/filesystem]'               >> ~/.config/polybar/config
echo 'type = internal/fs'                >> ~/.config/polybar/config
echo 'mount-0 = /'                       >> ~/.config/polybar/config
echo 'mount-1 = /home'                   >> ~/.config/polybar/config
echo 'mount-1 = /mnt'                    >> ~/.config/polybar/config
echo ''                                  >> ~/.config/polybar/config
echo '[bar/bar]'                         >> ~/.config/polybar/config
echo 'monitor ='                         >> ~/.config/polybar/config
echo 'bottom = true'                     >> ~/.config/polybar/config
echo 'width = 100%'                      >> ~/.config/polybar/config
echo 'height = 5%'                       >> ~/.config/polybar/config
echo 'radius = 0'                        >> ~/.config/polybar/config
echo 'background = ${colors.background}' >> ~/.config/polybar/config
echo 'foreground = ${colors.foreground}' >> ~/.config/polybar/config
echo ''                                  >> ~/.config/polybar/config
echo 'modules-left = bspwm'              >> ~/.config/polybar/config
echo 'modules-center = date memory cpu battery temperature' >> ~/.config/polybar/config
echo 'modules-right = alsa xkeyboard xbacklight dpowermenu' >> ~/.config/polybar/config


# bspwm
mkdir ~/.config/bspwm
touch ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/bspwmrc
echo '#!/bin/sh'                                      > ~/.config/bspwm/bspwmrc
echo 'bspc monitor -d I II III IV V VI VII VIII IX X' >> ~/.config/bspwm/bspwmrc

# sxhkd
mkdir ~/.config/sxhkd
touch ~/.config/sxhkd/sxhkdrc

echo '#!/bin/sh'                              > ~/.config/sxhkd/sxhkdrc
echo 'super + Return'                        >> ~/.config/sxhkd/sxhkdrc
echo ' alacritty -e tmux'                    >> ~/.config/sxhkd/sxhkdrc
echo 'super + shift + Return'                >> ~/.config/sxhkd/sxhkdrc
echo ' pkill -USR1 -x sxhkd'                 >> ~/.config/sxhkd/sxhkdrc
echo 'super + {h,j,k,l}'                     >> ~/.config/sxhkd/sxhkdrc
echo ' bspc node -f {west,south,north,east}' >> ~/.config/sxhkd/sxhkdrc
