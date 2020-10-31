set -o errexit

BASE_URL='https://raw.githubusercontent.com/readysloth/Workspace-recreation/gentoo_py'



mkdir installation
pushd installation
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/create_configs.sh"
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/environment_install.sh"
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/polybar_chooser.sh"
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/stage3.sh"
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/compiling.py"
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/installation.py"
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/partitioning.py"
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/preinstallation.py"
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 "${BASE_URL}/utils.py"
    chmod +x *
popd

echo 'Installation scripts are in *installation* folder'
