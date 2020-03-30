PROJECT_NAME=keynav
download(){
    git clone https://github.com/$PROJECT_NAME/$PROJECT_NAME.git
    # Install plugin manager
    git clone https://github.com/VundleVim/Vundle.$PROJECT_NAME.git
}

download_dependencies(){
    echo
}

install_dependencies(){
    sudo apt-get -y install \
                    ncurses-dev \
                    cmake 
}

download_misc(){
    mkdir ${PROJECT_NAME}_plugins
    pushd ${PROJECT_NAME}_plugins
        git clone --depth=1 http://github.com/lyokha/$PROJECT_NAME-xkbswitch      &
        git clone --depth=1 http://github.com/ierton/xkb-switch.git     &
        git clone --depth=1 http://github.com/scrooloose/nerdtree       &
        git clone --depth=1 http://github.com/godlygeek/tabular         &
        git clone --depth=1 http://github.com/scrooloose/syntastic      &
        git clone --depth=1 http://github.com/tpope/$PROJECT_NAME-fugitive        &
        git clone --depth=1 http://github.com/sheerun/$PROJECT_NAME-polyglot      &
        git clone --depth=1 http://github.com/easymotion/$PROJECT_NAME-easymotion &
        git clone --depth=1 http://github.com/mbbill/undotree           &
        git clone --depth=1 http://github.com/valloric/youcompleteme    &
        git clone --depth=1 http://github.com/davidhalter/jedi-$PROJECT_NAME      &
        git clone --depth=1 http://github.com/mkitt/tabline.$PROJECT_NAME         &
    popd
}

install_misc(){
    pushd ${PROJECT_NAME}_plugins
        pushd xkb-switch
            mkdir build; cd build
                cmake ..
                make -j$(nproc)
                sudo make install
        popd 

        mkdir -p ~/.$PROJECT_NAME/bundle/
        cp -r Vundle.$PROJECT_NAME ~/.$PROJECT_NAME/bundle/Vundle.$PROJECT_NAME

        $PROJECT_NAME +PluginInstall +qall

    popd
}

install(){
    pushd $PROJECT_NAME
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
