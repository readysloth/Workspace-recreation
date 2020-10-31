import os
import shlex
import subprocess as sp

def call_cmd(cmd: str, *args) -> bytes:
    combined_args = ' '.join(cmd.split() + list(args))
    return sp.check_output(['bash', '-c'] + [combined_args])


def call_cmd_and_print_content(cmd: str, *args):
    print(call_cmd(cmd, *args))


def call_cmd_and_print_cmd(cmd: str, *args) -> bytes:
    print(' '.join(cmd.split() + list(args)))
    return call_cmd(cmd, *args).decode('utf-8')


def source(source_file: str):
    command = shlex.split(f"env -i bash -c 'source {source_file} && env'")
    proc = subprocess.Popen(command, stdout = subprocess.PIPE).decode('utf-8')
    for line in proc.stdout:
        (key, _, value) = line.partition("=")
        os.environ[key] = value

