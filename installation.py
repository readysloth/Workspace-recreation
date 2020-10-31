import sys
import select

from utils import call_cmd_and_print_cmd, source

def emerge_base():
    call_cmd_and_print_cmd('emerge-webrsync')
    call_cmd_and_print_cmd('emerge --oneshot sys-apps/portage')

    call_cmd_and_print_cmd('emerge app-portage/gentoolkit')

    print(call_cmd_and_print_cmd('eselect profile list'))

    print('select profile:')
    profile_choice, _, _ = select.select([sys.stdin], [], [], 10)

    profile_choice = profile_choice if profile_choice else 20

    call_cmd_and_print_cmd('eselect profile set {profile_choice}')

    print(call_cmd_and_print_cmd('eselect profile list'))

    call_cmd_and_print_cmd('emerge app-portage/cpuid2cpuflags')
    call_cmd_and_print_cmd('echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags')


def install(boot_device: str):
    source('/etc/profile')
    call_cmd_and_print_cmd(f'mount {boot_device} /boot')
    call_cmd_and_print_cmd('mkdir /home/gentoo')
    emerge_base()
    #compiling.compile()
    call_cmd_and_print_cmd('rc-update add dhcpcd default')