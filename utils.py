import os
import shlex
import subprocess as sp

def call_cmd(cmd: str, *args) -> bytes:
    combined_args = ' '.join(cmd.split() + list(args))
    return sp.check_output(['bash', '-c'] + [combined_args])


def call_cmd_and_print_content(cmd: str, *args):
    print(call_cmd(cmd, *args))


def call_cmd_and_print_cmd(cmd: str, *args) -> bytes:
    full_cmd = ' '.join(cmd.split() + list(args))
    print(f'### cmd: [{full_cmd}] ### cwd: [{os.getcwd()}] ###')
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

