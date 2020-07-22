BASE_URL='https://raw.githubusercontent.com/readysloth/Workspace-recreation/gentoo'

mkdir installation
pushd installation
    wget "${BASE_URL}/compiling.sh"
    wget "${BASE_URL}/configuring.sh"
    wget "${BASE_URL}/download_scripts.sh"
    wget "${BASE_URL}/installation"
    wget "${BASE_URL}/installation.sh"
    wget "${BASE_URL}/partitioning.sh"
    wget "${BASE_URL}/preinstallation.sh"

    chmod +x *
popd

echo 'Installation scripts are in *installation* folder'
