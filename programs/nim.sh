PROJECT_NAME=Nim
download(){
    git clone --depth=1 git clone https://github.com/nim-lang/$PROJECT_NAME.git
}

download_dependencies(){
    pushd $PROJECT_NAME
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
    pushd $PROJECT_NAME
        bash build_all.sh
    popd
}

"$@"
