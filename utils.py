import subprocess as sp

def call_cmd(cmd: str, *args) -> bytes:
    return sp.check_output(cmd.split() + list(args))
