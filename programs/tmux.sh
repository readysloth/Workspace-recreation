PROJECT_NAME=tmux
download(){
    git clone --depth=1 https://github.com/$PROJECT_NAME/$PROJECT_NAME.git
}

download_dependencies(){
    echo
}

install_dependencies(){
    sudo apt-get -y install  \
                    autoconf \
                    automake \
                    pkg-config
}

download_misc(){
    wget https://$PROJECT_NAME.reconquest.io/pkg/deb/$PROJECT_NAME-autocomplete_2.0.5.gc0658bf.deb -O $PROJECT_NAME-autocomplete.deb
}

install_misc(){
    sudo dpkg -i $PROJECT_NAME-autocomplete.deb
    cp configs/.$PROJECT_NAME.conf ~/
}

install(){
    pushd $PROJECT_NAME
        sh autogen.sh
        ./configure && make -j$(nproc)
        sudo make install
    popd
}

"$@"
