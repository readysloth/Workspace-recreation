import os
import shlex
import subprocess as sp

class Colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    MAGENTA = '\033[35;1m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def call_cmd(cmd: str, *args) -> bytes:
    combined_args = ' '.join(cmd.split() + list(args))
    return sp.check_output(['bash', '-c'] + [combined_args])


def call_cmd_and_print_content(cmd: str, *args):
    print(call_cmd(cmd, *args))


def call_cmd_and_print_cmd(cmd: str, *args) -> bytes:
    full_cmd = ' '.join(cmd.split() + list(args))
    print(f'{Colors.OKCYAN}### cmd: [{Colors.MAGENTA}{full_cmd}{Colors.OKCYAN}] ### cwd: [{Colors.MAGENTA}{os.getcwd()}{Colors.OKCYAN}] ###{Colors.ENDC}')
    return call_cmd(cmd, *args).decode('utf-8')


def source(source_file: str):
    command = shlex.split(f"env -i bash -c 'source {source_file} && env'")
    print(command)
    proc = sp.Popen(command, stdout = sp.PIPE)
    for line in proc.stdout:
        formatted_line = line.decode('utf-8').strip()
        print(formatted_line)
        (key, _, value) = formatted_line.partition('=')
        os.environ[key] = value

