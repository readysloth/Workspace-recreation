download(){
    git clone https://github.com/baskerville/bspwm.git
}

download_dependencies(){
    pushd bspwm
        git clone https://gitlab.freedesktop.org/xorg/lib/libxcb.git &
        git clone https://gitlab.freedesktop.org/xorg/proto/xcbproto.git &
	git clone --recursive https://gitlab.freedesktop.org/xorg/lib/libxcb-util.git &
	wait $(jobs -p)
    popd
}

install_dependencies(){
    pushd bspwm
        sudo apt-get -y install \
                            autoconf \
                            automake \
                            pkg-config \
			    xutils-dev \
			    libtool
	pushd xcbproto
            sh autogen.sh
	    make -j$(nproc)
	    sudo make install
	popd

	pushd libxcb-util
            sh autogen.sh
	    make -j$(nproc)
	    sudo make install
	popd

	pushd libxcb
	    sh autogen.sh
	    make -j$(nproc)
	    sudo make install
	popd
    popd
}

download_misc(){
    pushd st
        mkdir st_patches
        pushd st_patches

            #wget https://st.suckless.org/patches/hidecursor/st-hidecursor-0.8.1.diff
            wget https://github.com/juliusHuelsmann/st/releases/download/patchesV3/st-alphaFocusHighlight-20200216-26cdfeb.diff

        popd
    popd
}

install_misc(){
    pushd st
        for patch in $(ls st_patches); do
            git apply -3 st_patches/$patch
        done
    popd
}

install(){
    pushd st
        sed -i '/static char *font =/ s/pixelsize=../pixelsize=16/' config.h
        make -j$(nproc)
        sudo make install
    popd
}

"$@"
