import os
import shlex
import subprocess as sp

def call_cmd(cmd: str, *args) -> bytes:
    return sp.check_output(['bash', '-c'] + cmd.split() + list(args))


def call_cmd_and_print_content(cmd: str, *args):
    print(call_cmd(cmd, *args))


def call_cmd_and_print_cmd(cmd: str, *args):
    print(cmd.split() + list(args))
    call_cmd(cmd, *args)


def source(source_file: str):
    command = shlex.split(f"env -i bash -c 'source {source_file} && env'")
    proc = subprocess.Popen(command, stdout = subprocess.PIPE).decode('utf-8')
    for line in proc.stdout:
        (key, _, value) = line.partition("=")
        os.environ[key] = value

