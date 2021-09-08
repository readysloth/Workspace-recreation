# I'm aware about heredocuments, but don't like them

RECREATION_DIR="$(mktemp -d)"
git clone https://github.com/readysloth/Workspace-recreation.git "$RECREATION_DIR"

SIJI_FONT_DIR="$(mktemp -d)"
git clone https://github.com/stark/siji "$SIJI_FONT_DIR"
pushd "$SIJI_FONT_DIR"
    ./install.sh -d ~/.fonts
popd

cd "$RECREATION_DIR"
# misc
echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf
mkdir ~/Images
cp -r "${RECREATION_DIR}/wallpapers" ~/Images

# scripts
mkdir ~/.scripts
echo '#!/bin/bash'                                      > ~/.scripts/autochanging_wallpaper.sh
echo 'while true'                                      >> ~/.scripts/autochanging_wallpaper.sh
echo 'do'                                              >> ~/.scripts/autochanging_wallpaper.sh
echo '  feh --randomize --bg-fill ~/Images/wallpapers' >> ~/.scripts/autochanging_wallpaper.sh
echo '  sleep 1h'                                      >> ~/.scripts/autochanging_wallpaper.sh
echo 'done'                                            >> ~/.scripts/autochanging_wallpaper.sh


echo '#!/bin/bash'                                           > ~/.scripts/make_screenshot.sh
echo ''                                                     >> ~/.scripts/make_screenshot.sh
echo 'TEMP_DIR=$(mktemp -d)'                                >> ~/.scripts/make_screenshot.sh
echo 'pushd $TEMP_DIR'                                      >> ~/.scripts/make_screenshot.sh
echo '    scrot'                                            >> ~/.scripts/make_screenshot.sh
echo '    xclip -i -selection clipboard -t image/png *.png' >> ~/.scripts/make_screenshot.sh
echo 'popd'                                                 >> ~/.scripts/make_screenshot.sh

chmod +x ~/.scripts/autochanging_wallpaper.sh
chmod +x ~/.scripts/make_screenshot.sh

# bashrc
echo "bind 'set completion-ignore-case on'"       > ~/.bashrc
echo 'export EDITOR=vim'                         >> ~/.bashrc
echo 'alias ls=exa'                              >> ~/.bashrc
echo 'alias l=exa'                               >> ~/.bashrc
echo 'alias cat=bat'                             >> ~/.bashrc
echo 'export PATH=$PATH:~/.cargo/bin:~/.scripts' >> ~/.bashrc

# fishrc
mkdir -p ~/.config/fish/
echo 'set -gx PATH $PATH ~/.cargo/bin ~/.scripts ~/.local/bin' >> ~/.config/fish/config.fish

# Xinit
echo 'sxhkd &'                                           > ~/.xinitrc
echo "xset +fp $(echo ~/.fonts)"                        >> ~/.xinitrc
echo "xset fp rehash"                                   >> ~/.xinitrc
echo 'compton &'                                        >> ~/.xinitrc
echo 'clipmenud &'                                      >> ~/.xinitrc
echo 'setxkbmap -option grp:alt_shift_toggle dvorak,ru' >> ~/.xinitrc
echo '~/.config/polybar/launch.sh &'                    >> ~/.xinitrc
echo '~/.scripts/autochanging_wallpaper.sh &'           >> ~/.xinitrc
echo 'exec bspwm'                                       >> ~/.xinitrc

# synaptics

echo 'Section "InputClass"'                           > /etc/X11/xorg.conf.d/50-synaptics.conf
echo '        Identifier "touchpad catchall"'        >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo '        Driver "synaptics"'                    >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo '        MatchIsTouchpad "on"'                  >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo '        Option "VertEdgeScroll" "on"'          >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo                                                 >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo '        Option "CircularScrolling"     "on"'   >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo '        Option "CircScrollTrigger"     "0"'    >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo '        Option "CircScrollDelta"       "0.01"' >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo                                                 >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo '        Option "VertTwoFingerScroll"   "on"'   >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo '        Option "VertScrollDelta"       "30"'   >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo '        Option "HorizScrollDelta"      "30"'   >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo '        Option "TapButton1"       	   "1"'    >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo '        Option "TapButton2"       	   "3"'    >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo '        Option "TapButton3"       	   "2"'    >> /etc/X11/xorg.conf.d/50-synaptics.conf
echo 'EndSection

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
echo                      >> ~/.vimrc
echo 'syntax on'          >> ~/.vimrc
echo                      >> ~/.vimrc

echo 'nnoremap <C-j> :m .+1<CR>'          >> ~/.vimrc
echo 'nnoremap <C-k> :m .-2<CR>'          >> ~/.vimrc
echo                                      >> ~/.vimrc
echo 'inoremap <C-j> <ESC>:m .+1<CR>==gi' >> ~/.vimrc
echo 'inoremap <C-k> <ESC>:m .-2<CR>==gi' >> ~/.vimrc
echo                                      >> ~/.vimrc
echo "vnoremap <C-j> :m '>1<CR>gv=gv"     >> ~/.vimrc
echo "vnoremap <C-k> :m '<2<CR>gv=gv"     >> ~/.vimrc
echo                                      >> ~/.vimrc

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
echo "Plug 'unblevable/quick-scope'"          >> ~/.vimrc
echo "Plug 'wlangstroth/vim-racket'"          >> ~/.vimrc
echo "Plug 'calebsmith/vim-lambdify'"         >> ~/.vimrc
echo "Plug 'ntpeters/vim-better-whitespace'"  >> ~/.vimrc
echo "Plug 'mhinz/vim-signify'"               >> ~/.vimrc
echo "Plug 'wsdjeg/vim-fetch'"                >> ~/.vimrc
echo "Plug 'Galicarnax/vim-regex-syntax'"     >> ~/.vimrc
echo                                          >> ~/.vimrc
echo "call plug#end()"                        >> ~/.vimrc
echo                                          >> ~/.vimrc
echo 'map <C-n> :NERDTreeToggle<CR>'                 >> ~/.vimrc
echo 'map U :UndotreeToggle<CR>'                     >> ~/.vimrc
echo 'map gG :G<CR>'                                 >> ~/.vimrc
echo                                                 >> ~/.vimrc
echo 'set updatetime=100'                            >> ~/.vimrc
echo                                                 >> ~/.vimrc
echo 'let g:rainbow_active = 1'                      >> ~/.vimrc
echo 'let g:indent_guides_enable_on_vim_startup = 1' >> ~/.vimrc
echo 'let g:XkbSwitchEnabled = 1'                    >> ~/.vimrc
echo 'let g:diminactive_use_syntax = 1'              >> ~/.vimrc
echo "let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']" >> ~/.vimrc
echo                                                 >> ~/.vimrc
echo 'autocmd VimEnter * DimInactiveOn'              >> ~/.vimrc
echo                                                 >> ~/.vimrc
echo 'let g:diminactive_use_syntax = 1'              >> ~/.vimrc
echo 'let g:diminactive_use_colorcolumn = 0'         >> ~/.vimrc

vim +PlugInstall +qa


# tmux
echo 'set -g prefix C-a'                                       > ~/.tmux.conf
echo ''                                                       >> ~/.tmux.conf
echo 'set-option -g default-shell /bin/fish'                  >> ~/.tmux.conf
echo ''                                                       >> ~/.tmux.conf
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
echo 'set-window-option -g mode-keys vi'                      >> ~/.tmux.conf


# alacritty
mkdir ~/.config/alacritty
pushd ~/.config/alacritty
    wget https://github.com/alacritty/alacritty/releases/download/v0.5.0/alacritty.yml
    sed -i  -e 's/#env:/env:/' \
            -e 's/#TERM:/TERM:/' \
            -e 's/#window:/window:/' \
            -e 's/#background_opacity:.*/background_opacity: 0.7/' \
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
/polybar_chooser.sh 11
sed -i '/font-1.*=.*"/ s/"[^"]*"/"Wuncon Siji:size=11"/' ~/.config/polybar/config.ini


# bspwm
mkdir ~/.config/bspwm
touch ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/bspwmrc
echo '#!/bin/sh'                                      > ~/.config/bspwm/bspwmrc
echo 'bspc monitor -d I II III IV V VI VII VIII IX X' >> ~/.config/bspwm/bspwmrc
echo 'bspc config border_width 2'                     >> ~/.config/bspwm/bspwmrc
echo 'bspc config borderless_monocle true'            >> ~/.config/bspwm/bspwmrc
echo 'bspc config gapless_monocle true'               >> ~/.config/bspwm/bspwmrc
echo 'bspc config focus_follows_pointer true'         >> ~/.config/bspwm/bspwmrc

# sxhkd
mkdir ~/.config/sxhkd
touch ~/.config/sxhkd/sxhkdrc

echo '#!/bin/sh'                               > ~/.config/sxhkd/sxhkdrc

echo 'super + shift + {z,a}'                  >> ~/.config/sxhkd/sxhkdrc
echo ' bspc node @/ -C {forward,backward}'    >> ~/.config/sxhkd/sxhkdrc
echo 'super + Return'                         >> ~/.config/sxhkd/sxhkdrc
echo ' alacritty -e tmux'                     >> ~/.config/sxhkd/sxhkdrc
echo                                          >> ~/.config/sxhkd/sxhkdrc
echo 'super + c'                              >> ~/.config/sxhkd/sxhkdrc
echo ' CM_LAUNCHER=rofi clipmenu -i'          >> ~/.config/sxhkd/sxhkdrc
echo                                          >> ~/.config/sxhkd/sxhkdrc
echo 'super + Tab'                            >> ~/.config/sxhkd/sxhkdrc
echo ' setxkbmap -option grp:alt_shift_toggle {dvorak, us},ru' >> ~/.config/sxhkd/sxhkdrc
echo                                          >> ~/.config/sxhkd/sxhkdrc
echo 'Print'                                  >> ~/.config/sxhkd/sxhkdrc
echo ' flameshot gui'                         >> ~/.config/sxhkd/sxhkdrc
echo                                          >> ~/.config/sxhkd/sxhkdrc
echo 'super + t'                                      >> ~/.config/sxhkd/sxhkdrc
echo ' bash ~/.config/polybar/scripts/colors_rofi.sh' >> ~/.config/sxhkd/sxhkdrc
echo                                                  >> ~/.config/sxhkd/sxhkdrc
echo 'XF86AudioRaiseVolume'      >> ~/.config/sxhkd/sxhkdrc
echo ' amixer set Master 2%+'    >> ~/.config/sxhkd/sxhkdrc
echo 'XF86AudioLowerVolume'      >> ~/.config/sxhkd/sxhkdrc
echo ' amixer set Master 2%-'    >> ~/.config/sxhkd/sxhkdrc
echo 'XF86AudioMute'             >> ~/.config/sxhkd/sxhkdrc
echo ' amixer set Master toggle' >> ~/.config/sxhkd/sxhkdrc
echo 'XF86MonBrightnessUp'       >> ~/.config/sxhkd/sxhkdrc
echo ' xbacklight +5'            >> ~/.config/sxhkd/sxhkdrc
echo 'XF86MonBrightnessDown'     >> ~/.config/sxhkd/sxhkdrc
echo ' xbacklight -5'            >> ~/.config/sxhkd/sxhkdrc
echo                                          >> ~/.config/sxhkd/sxhkdrc
echo 'super + n'                              >> ~/.config/sxhkd/sxhkdrc
echo ' firefox'                               >> ~/.config/sxhkd/sxhkdrc
echo 'super + f'                              >> ~/.config/sxhkd/sxhkdrc
echo ' bspc node -t ~fullscreen'              >> ~/.config/sxhkd/sxhkdrc
echo 'super + shift + Return'                 >> ~/.config/sxhkd/sxhkdrc
echo ' pkill -USR1 -x sxhkd'                  >> ~/.config/sxhkd/sxhkdrc
echo 'super + {j,k,j,p}'                      >> ~/.config/sxhkd/sxhkdrc
echo ' bspc node -f {west,south,north,east}'  >> ~/.config/sxhkd/sxhkdrc
echo 'super + d'                              >> ~/.config/sxhkd/sxhkdrc
echo ' rofi -show run'                        >> ~/.config/sxhkd/sxhkdrc
echo 'super + shift + d'                      >> ~/.config/sxhkd/sxhkdrc
echo ' rofi -show drun'                       >> ~/.config/sxhkd/sxhkdrc
echo 'super + shift + q'                      >> ~/.config/sxhkd/sxhkdrc
echo ' bspc node -{c,k}'                      >> ~/.config/sxhkd/sxhkdrc
echo 'super + {_,shift + }{1-9,0}'            >> ~/.config/sxhkd/sxhkdrc
echo " bspc {desktop -f,node -d} '^{1-9,10}'" >> ~/.config/sxhkd/sxhkdrc
echo 'super + r'                              >> ~/.config/sxhkd/sxhkdrc
echo ' bspc node @/ -R 90'                    >> ~/.config/sxhkd/sxhkdrc
echo 'super + space'                          >> ~/.config/sxhkd/sxhkdrc
echo ' bspc node -t {floating, tiled}'        >> ~/.config/sxhkd/sxhkdrc



git config --global core.editor vim
