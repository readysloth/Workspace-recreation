# I'm aware about heredocuments, but don't like them

# Xinit
echo 'sxhkd &'    >> ~/.xinitrc
echo 'exec bspwm' >> ~/.xinitrc

# Vim
echo 'set number'         >> ~/.vimrc
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

# tmux
echo 'set -g prefix C-a'                                      >> ~/.tmux.conf
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



# bspwm
chmod +x ~/.config/bspwm/bspwmrc
