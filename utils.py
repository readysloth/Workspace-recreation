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
    with open('/dev/tty3', 'ab') as out_log:
        with open('/dev/tty2', 'ab') as err_log:
            combined_args = ' '.join(cmd.split() + list(args))
            out = sp.check_output([combined_args], shell=True, stderr=err_log)
            out_log.write(out)
            return out


def call_cmd_and_print_content(cmd: str, *args):
    print(call_cmd(cmd, *args))


def call_cmd_and_print_cmd(cmd: str, *args) -> bytes:
    full_cmd = ' '.join(cmd.split() + list(args))
    print(f'{Colors.OKCYAN}### cmd: [{Colors.MAGENTA}{full_cmd}{Colors.OKCYAN}] ### cwd: [{Colors.MAGENTA}{os.getcwd()}{Colors.OKCYAN}] ###{Colors.ENDC}')
    return call_cmd(cmd, *args).decode('utf-8')


def do_with_fallback(cmd: str, *fallback) -> bytes:
    try:
        return call_cmd_and_print_cmd(cmd)
    except Exception as e:
        print('Error occured!')
        if not fallback:
            print('No fallback specified')
        for f in fallback:
            try:
                print('Using fallback for', cmd)
                return call_cmd_and_print_cmd(f)
            except Exception as e:
                continue



def source(source_file: str):
    command = shlex.split(f"env -i bash -c 'source {source_file} && env'")
    proc = sp.Popen(command, stdout = sp.PIPE)
    for line in proc.stdout:
        formatted_line = line.decode('utf-8').strip()
        print(formatted_line)
        (key, _, value) = formatted_line.partition('=')
        os.environ[key] = value

