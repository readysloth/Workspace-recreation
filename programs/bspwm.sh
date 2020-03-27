download(){
    git clone https://github.com/baskerville/bspwm.git
}

download_dependencies(){
    pushd bspwm
    	mkdir dependencies
	pushd dependencies
            git clone https://gitlab.freedesktop.org/xorg/lib/libxcb.git &
            git clone https://gitlab.freedesktop.org/xorg/proto/xcbproto.git &
	    git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-util.git &
	    git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-wm.git &
	    git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-keysyms.git &
	    wait $(jobs -p)
	popd
    popd
}

install_dependencies(){
    pushd bspwm
	pushd dependencies
            sudo apt-get -y install \
                                autoconf \
                                automake \
                                pkg-config \
	    		        libtool
	    for dependency in $(ls)
	    do
	        pushd $dependency
                    sh autogen.sh
	            make -j$(nproc)
	            sudo make install
	        popd
	    done
	popd
    popd
    echo "/usr/local/lib" | sudo tee /etc/ld.so.conf.d/another-lib-folder.conf
    sudo ldconfig
}

download_misc(){
    echo
}

install_misc(){
    echo
}

install(){
    pushd bspwm
        make -j$(nproc)
        sudo make install
    popd
}

"$@"
