PROJECT_NAME=st
download(){
    git clone --depth=1 https://git.suckless.org/$PROJECT_NAME
}

download_dependencies(){
    echo
}

install_dependencies(){
    echo
}

download_misc(){
    pushd $PROJECT_NAME
        mkdir ${PROJECT_NAME}_patches
        pushd ${PROJECT_NAME}_patches
            wget https://github.com/juliusHuelsmann/$PROJECT_NAME/releases/download/patchesV3/$PROJECT_NAME-alphaFocusHighlight-20200216-26cdfeb.diff
        popd
    popd
}

install_misc(){
    pushd $PROJECT_NAME
        git update-index --refresh
        for patch in $(ls ${PROJECT_NAME}_patches); do
            git apply -3 ${PROJECT_NAME}_patches/$patch
        done
    popd
}

install(){
    pushd $PROJECT_NAME
        sed -i '/static char *font =/ s/pixelsize=../pixelsize=16/' config.def.h
        make -j$(nproc)
        sudo make install
    popd
}

"$@"
