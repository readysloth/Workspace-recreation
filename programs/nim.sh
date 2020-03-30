download(){
    git clone --depth=1 git clone https://github.com/nim-lang/Nim.git
}

download_dependencies(){
    pushd Nim
        git clone --depth 1 https://github.com/nim-lang/csources.git
    popd
}

install_dependencies(){
    echo
}

download_misc(){
    echo
}

install_misc(){
    echo
}

install(){
    pushd Nim
        bash build_all.sh
    popd
}

"$@"
