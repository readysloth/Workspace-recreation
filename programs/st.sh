download(){
    git clone --depth=1 https://git.suckless.org/st
}

download_dependencies(){
    echo
}

install_dependencies(){
    echo
}

download_misc(){
    pushd st
        mkdir st_patches
        pushd st_patches
            wget https://github.com/juliusHuelsmann/st/releases/download/patchesV3/st-alphaFocusHighlight-20200216-26cdfeb.diff
        popd
    popd
}

install_misc(){
    pushd st
        git update-index --refresh
        for patch in $(ls st_patches); do
            git apply -3 st_patches/$patch
        done
    popd
}

install(){
    pushd st
        sed -i '/static char *font =/ s/pixelsize=../pixelsize=16/' config.def.h
        make -j$(nproc)
        sudo make install
    popd
}

"$@"
