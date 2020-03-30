PROJECT_NAME=
download(){
    git clone --depth=1 https://git.suckless.org/$PROJECT_NAME
}

download_dependencies(){
    pushd $PROJECT_NAME
        mkdir dependencies
	pushd dependencies
            git clone --depth=1 https://github.com/mesonbuild/meson.git
            git clone --depth=1 git://github.com/ninja-build/ninja.git
	popd
    popd
}

install_dependencies(){
    pushd $PROJECT_NAME
	pushd dependencies
            pushd ninja   
                ./configure.py --bootstrap
            popd

            pushd meson   
            
            
            popd
	popd
    popd
}

download_misc(){
    pushd $PROJECT_NAME
        mkdir ${PROJECT_NAME}_patches
        pushd ${PROJECT_NAME}_patches
            wget https://$PROJECT_NAME.suckless.org/patches/web-search/$PROJECT_NAME-websearch-20190510-d068a38.diff                   &
            wget https://$PROJECT_NAME.suckless.org/patches/unicode-in-dmenu/$PROJECT_NAME-0.6-dmenu-unicode.diff                      &
            wget https://$PROJECT_NAME.suckless.org/patches/spacesearch/$PROJECT_NAME-spacesearch-20170408-b814567.diff                &
            wget https://$PROJECT_NAME.suckless.org/patches/searchengines/$PROJECT_NAME-0.3-searchengines.diff                         &
            wget https://$PROJECT_NAME.suckless.org/patches/navigation-history/$PROJECT_NAME-0.6-navhist.diff                          &
            wget https://$PROJECT_NAME.suckless.org/patches/modal/$PROJECT_NAME-modal-20190209-d068a38.diff                            &
            wget https://$PROJECT_NAME.suckless.org/patches/keycodes/$PROJECT_NAME-webkit2-keycodes-20170424-5c52733.diff              &
            wget https://$PROJECT_NAME.suckless.org/patches/homepage/$PROJECT_NAME-2.0-homepage.diff                                   &
            wget https://$PROJECT_NAME.suckless.org/patches/clipboard-instead-of-primary/$PROJECT_NAME-clipboard-20200112-a6a8878.diff &
            wait $(jobs -p)
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
        make -j$(nproc)
        sudo make install
    popd
}

"$@"
