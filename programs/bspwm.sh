download(){
    git clone https://github.com/baskerville/bspwm.git
}

download_dependencies(){
    pushd bspwm
    	mkdir dependencies
	pushd dependencies
            git clone https://gitlab.freedesktop.org/xorg/lib/libxcb.git 1libxcb&
            git clone https://gitlab.freedesktop.org/xorg/proto/xcbproto.git 2xcbproto&
	    git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-util.git 3libxcb-util&
	    git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-wm.git 3libxcb-wm&
	    git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-keysyms.git 3libxcb-keysyms&
	    git clone https://gitlab.freedesktop.org/xorg/util/macros.git 4macros&
	    git clone https://gitlab.freedesktop.org/xorg/lib/libxinerama.git 5libxinerama&
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
	    		        libtool \
				xutils-dev
	    for dependency in $(ls | sort)
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
