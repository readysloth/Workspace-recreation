import os
import glob
import shutil
import typing as t

from utils import call_cmd_and_print_cmd
import installation

def launch_ntpd():
    call_cmd_and_print_cmd('ntpd -q -g')


def stage3():
    call_cmd_and_print_cmd('bash stage3.sh')


def chroot_to_install():
    scripts = glob.glob('*.sh') + glob.glob('*.py')
    for script in scripts:
        shutil.copy(script, '/mnt/gentoo')

    os.chroot('/mnt/gentoo')
    os.chdir('/')
    

def preinstall(disk: str):
    launch_ntpd()
    call_cmd_and_print_cmd('echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6')
    stage3()
    chroot_to_install()
    installation.install(call_cmd_and_print_cmd(f"fdisk -l | grep '{disk}' | grep -i 'efi' | awk '{{print $1}}'"))

