download(){
    git clone --depth=1 https://git.suckless.org/surf
}

download_dependencies(){
    pushd surf
        mkdir dependencies
	pushd dependencies
            git clone --depth=1 https://github.com/mesonbuild/meson.git
            git clone --depth=1 git://github.com/ninja-build/ninja.git
	popd
    popd
}

install_dependencies(){
    pushd surf
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
    pushd surf
        mkdir surf_patches
        pushd surf_patches
            wget https://surf.suckless.org/patches/web-search/surf-websearch-20190510-d068a38.diff                   &
            wget https://surf.suckless.org/patches/unicode-in-dmenu/surf-0.6-dmenu-unicode.diff                      &
            wget https://surf.suckless.org/patches/spacesearch/surf-spacesearch-20170408-b814567.diff                &
            wget https://surf.suckless.org/patches/searchengines/surf-0.3-searchengines.diff                         &
            wget https://surf.suckless.org/patches/navigation-history/surf-0.6-navhist.diff                          &
            wget https://surf.suckless.org/patches/modal/surf-modal-20190209-d068a38.diff                            &
            wget https://surf.suckless.org/patches/keycodes/surf-webkit2-keycodes-20170424-5c52733.diff              &
            wget https://surf.suckless.org/patches/homepage/surf-2.0-homepage.diff                                   &
            wget https://surf.suckless.org/patches/clipboard-instead-of-primary/surf-clipboard-20200112-a6a8878.diff &
            wait $(jobs -p)
        popd
    popd
}

install_misc(){
    pushd surf
        git update-index --refresh
        for patch in $(ls surf_patches); do
            git apply -3 surf_patches/$patch
        done
    popd
}

install(){
    pushd surf
        #sed -i '/static char *font =/ s/pixelsize=../pixelsize=16/' config.def.h
        make -j$(nproc)
        sudo make install
    popd
}

"$@"
