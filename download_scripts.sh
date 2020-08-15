BASE_URL='https://raw.githubusercontent.com/readysloth/Workspace-recreation/gentoo'

mkdir installation
pushd installation
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/compiling.sh"
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/configuring.sh"
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/download_scripts.sh"
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/installation.sh"
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/partitioning.sh"
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/preinstallation.sh"
    chmod +x *
popd

echo 'Installation scripts are in *installation* folder'
