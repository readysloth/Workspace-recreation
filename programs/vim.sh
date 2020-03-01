
download(){
    git clone https://github.com/vim/vim.git
    # Install plugin manager
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}

install_dependencies(){
    sudo apt-get -y install \
                        ncurses-dev \
                        cmake 
}

download_misc(){
    mkdir vim_plugins
    pushd vim_plugins

    git clone http://github.com/lyokha/vim-xkbswitch
    git clone https://github.com/ierton/xkb-switch.git

    git clone http://github.com/scrooloose/nerdtree
    git clone http://github.com/godlygeek/tabular
    git clone http://github.com/scrooloose/syntastic
    git clone http://github.com/tpope/vim-fugitive
    git clone http://github.com/sheerun/vim-polyglot
    git clone http://github.com/easymotion/vim-easymotion
    git clone http://github.com/mbbill/undotree
    git clone http://github.com/valloric/youcompleteme
    git clone http://github.com/davidhalter/jedi-vim
    git clone http://github.com/mkitt/tabline.vim
    
    popd
}

install_misc(){
    pushd vim_plugins/xkb-switch
        mkdir build; cd build
            cmake ..
            make -j$(nproc)
            sudo make install

    vim +PluginInstall +qall

    popd
}

install(){
    pushd vim
        ./configure --enable-pythoninterp=on \
                  --enable-python3interp=on \
                  --enable-multibyte=on \
                  --with-x
        make distclean
        make -j$(nproc)
        sudo make install
    popd
}

"$@"
