#!/usr/bin/env python3
#
# This script is executed at the start of each interactive python
# console when it is defined in the PYTHONSTARTUP environment variable.

import atexit
import os
import readline

histfile = os.environ.get(
    "PYTHONHISTORY",
    (
        os.environ.get("XDG_DATA_HOME", "%s/.local/share" % os.environ["HOME"])
        + "/python/python_history"
    ),
)

if not os.path.exists(os.path.dirname(histfile)):
    os.makedirs(os.path.dirname(histfile))
if not os.path.exists(histfile):
    with open(histfile, "a") as f:
        f.write("_HiStOrY_V2_\n")
else:
    readline.read_history_file(histfile)
atexit.unregister(readline.write_history_file)
atexit.register(readline.write_history_file, histfile)
