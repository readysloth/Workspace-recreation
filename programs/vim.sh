
download(){
    git clone https://github.com/vim/vim.git
    # Install plugin manager
    git clone https://github.com/VundleVim/Vundle.vim.git
}

install_dependencies(){
    sudo apt-get -y install \
                    ncurses-dev \
                    cmake 
}

download_misc(){
    mkdir vim_plugins
    pushd vim_plugins
        git clone --depth=1 http://github.com/lyokha/vim-xkbswitch      &
        git clone --depth=1 http://github.com/ierton/xkb-switch.git     &
        git clone --depth=1 http://github.com/scrooloose/nerdtree       &
        git clone --depth=1 http://github.com/godlygeek/tabular         &
        git clone --depth=1 http://github.com/scrooloose/syntastic      &
        git clone --depth=1 http://github.com/tpope/vim-fugitive        &
        git clone --depth=1 http://github.com/sheerun/vim-polyglot      &
        git clone --depth=1 http://github.com/easymotion/vim-easymotion &
        git clone --depth=1 http://github.com/mbbill/undotree           &
        git clone --depth=1 http://github.com/valloric/youcompleteme    &
        git clone --depth=1 http://github.com/davidhalter/jedi-vim      &
        git clone --depth=1 http://github.com/mkitt/tabline.vim         &
    popd
}

install_misc(){
    pushd vim_plugins
        pushd xkb-switch
            mkdir build; cd build
                cmake ..
                make -j$(nproc)
                sudo make install
        popd 

        mkdir -p ~/.vim/bundle/
        cp -r Vundle.vim ~/.vim/bundle/Vundle.vim

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
