PROJECT_NAME=keynav
download(){
    git clone --depth=1 https://github.com/jordansissel/$PROJECT_NAME.git
}

download_dependencies(){
    pushd $PROJECT_NAME
    	mkdir dependencies
	pushd dependencies
            git clone --depth=1 https://gitlab.freedesktop.org/xorg/lib/libxcb.git 1libxcb                             &
            git clone --depth=1 https://gitlab.freedesktop.org/xorg/proto/xcbproto.git 2xcbproto                       &
	    git clone --depth=1 --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-util.git 3libxcb-util       &
	    git clone --depth=1 --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-wm.git 3libxcb-wm           &
	    git clone --depth=1 --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-keysyms.git 3libxcb-keysyms &
	    git clone --depth=1 https://gitlab.freedesktop.org/xorg/util/macros.git 4macros                            &
	    git clone --depth=1 https://gitlab.freedesktop.org/xorg/lib/libxinerama.git 5libxinerama                   &
	    wait $(jobs -p)
	popd
    popd
}

install_dependencies(){
    pushd $PROJECT_NAME
	pushd dependencies
            sudo apt-get -y install    \
                            autoconf   \
                            automake   \
                            pkg-config \
	    		    libtool    \
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
    pushd $PROJECT_NAME
        make -j$(nproc)
        sudo make install
    popd
}

"$@"
