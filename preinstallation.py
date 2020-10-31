import os
import glob
import shutil
import typing as t

from utils import call_cmd
import installation

def launch_ntpd():
    call_cmd('ntpd -q -g')


def stage3():
    call_cmd('bash stage3.sh')


def chroot_to_install(partition: str):
    scripts = glob.glob('*.sh') + glob.glob('*.py')
    for script in scripts:
        shutil.copy(script, '/mnt/gentoo')

    os.chroot('/mnt/gentoo')
    installation.install(partition)
    

def preinstall(partition: str):
    launch_ntpd()
    stage3()
    chroot_to_install(partition)

