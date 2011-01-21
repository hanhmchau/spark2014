
"""
This module contains support functions for all test.py
"""

import os
import sys
import re

#  Change directory

TEST = sys.modules['__main__']
TESTDIR = os.path.dirname(TEST.__file__)
TEST_NAME = os.path.basename(TESTDIR)
os.chdir(TESTDIR)

from gnatpython.ex import Run

def cat(filename):
    """Dump the content of a file on stdout

    PARAMETERS
      filename: name of the file to print on stdout
    """
    with open(filename, 'r') as f:
        print f.read()

def gnat2why(src, opt=None):
    """Invoke gnat2why

    PARAMETERS
      src: source file to process
      opt: additional options to pass to gnat2why
    """
    cmd = ["gnat2why",
           "-I" + get_path_to_adainclude()]
    cmd += to_list(opt)
    cmd += [src]
    process = Run(cmd)
    if process.status:
        print process.out

def why(src, opt=None):
    """Invoke why

    PARAMETERS
      src: source file to process
      opt: additional options to pass to why
    """
    cmd = ["why"]
    cmd += to_list(opt)
    cmd += [src]
    process = Run(cmd)
    if process.status:
        print process.out

def altergo(src, opt=None):
    """Invoke alt-ergo

    PARAMETERS
      src: source file to process
      opt: additional options to pass to alt-ergo
    """
    cmd = ["alt-ergo"]
    cmd += to_list(opt)
    cmd += [src]
    process = Run(cmd)
    # Remove Filename, linenumber and time of proof, just keep status
    res = re.compile(".*:(.*)\(.*")
    for line in str.splitlines(process.out):
       m = re.search(res, line)
       if m:
          print m.group(1)
       else:
          print line

def to_list(arg):
    """Convert to list

    If arg is already a list, return it unchanged. Otherwise, if it is
    None, return an empty list. In any other case, wrap the argument in
    a list (that contains, as a consequence, only one element).
    """
    if arg is None:
        return []
    elif isinstance(arg, list):
        return arg
    else:
        return [arg]

def get_path_to_adainclude():
    """Return path to adainclude
    """
    cmd=[["gnatls", "-v"], ["grep", "adainclude"]]
    process = Run(cmd)
    return process.out.strip()

