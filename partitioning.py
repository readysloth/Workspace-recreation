import sys
import datetime
import typing as t
import subprocess as sp

from utils import call_cmd_and_print_cmd

import preinstallation

DISK = sys.argv[1]
LVM_GROUP_NAME = 'vg01'

def wipefs(disk: str):
    call_cmd_and_print_cmd('wipefs -af', disk)


def remove_lvm_groups()
    existing_lvm_groups = call_cmd_and_print_cmd("vgs | sed -n 2,\$p | awk '{print $1}'")

    call_cmd_and_print_cmd('vgremove -y', existing_lvm_groups)


def make_partitions(disk: str) -> t.Tuple[str]:
    def call_parted(cmd: str):
        call_cmd_and_print_cmd('parted -a optimal --script', disk, cmd)
    
    def make_bootloader():
        call_parted('mklabel gpt')
        call_parted('mkpart primary 1MiB 3MiB')
        call_parted('name 1 grub')
        call_parted('set 1 bios_grub on')

    def make_boot():
        call_parted('mkpart primary 3MiB 259MiB')
        call_parted('name 2 boot')
        call_parted('set 2 boot on')

    def free_space_to_lvm():
        call_parted('mkpart primary 259MiB -1')
        call_parted('name 3 lvm01')
        call_parted('set 3 lvm on')

    make_bootloader()
    make_boot()
    free_space_to_lvm()

    part1 = call_cmd_and_print_cmd("fdisk -l | grep {d} | tail -n +2 | sed -n 1p | awk '{print $1}'".format(d=disk)).decode('utf-8')
    part2 = call_cmd_and_print_cmd("fdisk -l | grep {d} | tail -n +2 | sed -n 2p | awk '{print $1}'".format(d=disk)).decode('utf-8')
    part3 = call_cmd_and_print_cmd("fdisk -l | grep {d} | tail -n +2 | sed -n 3p | awk '{print $1}'".format(d=disk)).decode('utf-8')

    return (part1, part2, part3)


def start_lvm_daemon():
    call_cmd_and_print_cmd('/etc/init.d/lvm start')


def create_phy_volume(partition: str):
    call_cmd_and_print_cmd('pvcreate', partition)
    call_cmd_and_print_cmd('vgcreate', LVM_GROUP_NAME, partition)


def allocate_space_for_lvm():
    call_cmd_and_print_cmd('lvcreate -y -L 2048M   -n swap', LVM_GROUP_NAME)
    call_cmd_and_print_cmd('lvcreate -y -l 50%FREE -n rootfs', LVM_GROUP_NAME)
    call_cmd_and_print_cmd('lvcreate -y -l 50%FREE -n home', LVM_GROUP_NAME)


def make_fs_and_swap(partition: str):
    call_cmd_and_print_cmd('mkfs.fat -F 32', partition)
    call_cmd_and_print_cmd(f'mkfs.ext4 /dev/{LVM_GROUP_NAME}/rootfs')
    call_cmd_and_print_cmd(f'mkfs.ext4 /dev/{LVM_GROUP_NAME}/home')

    call_cmd_and_print_cmd(f'mkswap /dev/{LVM_GROUP_NAME}/swap')
    call_cmd_and_print_cmd(f'swapon /dev/{LVM_GROUP_NAME}/swap')


def mount_devices_for_os_install():
    call_cmd_and_print_cmd(f'mount /dev/{LVM_GROUP_NAME}/rootfs /mnt/gentoo')
    call_cmd_and_print_cmd(f'mkdir /mnt/gentoo/home')
    call_cmd_and_print_cmd(f'mount /dev/{LVM_GROUP_NAME}/home /mnt/gentoo/home')


if __name__ == 'main':
    try:
        wipefs(DISK)
    except sp.CalledProcessError as e:
        print(e)

    try:
        remove_lvm_groups()
    except sp.CalledProcessError as e:
        print(e)

    part1, part2, part3 = make_partitions(DISK)
    start_lvm_daemon()
    create_phy_volume(part3)
    allocate_space_for_lvm()
    make_fs_and_swap(part2)
    mount_devices_for_os_install()

    start_time = datetime.datetime.now()
    preinstallation.preinstall(part1)
    end_time = datetime.datetime.now()

    print('start time:', start_time)
    print('end time  :', end_time)
