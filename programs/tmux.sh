
download(){
    git clone --depth=1 https://github.com/tmux/tmux.git
}

install_dependencies(){
    sudo apt-get -y install  \
                    autoconf \
                    automake \
                    pkg-config
}

download_misc(){
    wget https://tmux.reconquest.io/pkg/deb/tmux-autocomplete_2.0.5.gc0658bf.deb -O tmux-autocomplete.deb
}

install_misc(){
    sudo dpkg -i tmux-autocomplete.deb
    cp configs/.tmux.conf ~/

}

install(){
    pushd tmux
        sh autogen.sh
        ./configure && make -j$(nproc)
        sudo make install
    popd
}

"$@"
