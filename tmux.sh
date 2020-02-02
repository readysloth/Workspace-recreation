
download(){
    git clone https://github.com/tmux/tmux.git
}

install_dependencies(){
    apt-get -y install \
                        autoconf \
                        automake \
                        pkg-config
}

download_misc(){
    echo

}

install_misc(){
    echo

}

install(){
    pushd tmux
    sh autogen.sh
    ./configure && make -j$(nproc)
    make install
    popd
}

"$@"
