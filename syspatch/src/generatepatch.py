# SPDX-License-Identifier: GPL-3.0
# SysPatch
# A simple tool to create and apply patches to a system.
#
# syspatch/src/generatepatch.py
#
# GNU General Public License v3.0
# Copyright (C) 2024 0x4248

import sys
import os
import shutil
try:
    import toml
except ImportError:
    print("Please install toml package. Run: pip install toml")
    sys.exit(1)

import tarfile


def main():
    if len(sys.argv) != 3:
        print("Usage: generatepatch.py <source> <build>")
        sys.exit(1)

    source = sys.argv[1]
    build = sys.argv[2]

    if not os.path.exists(source):
        print("Source does not exist")
        sys.exit(1)

    if not os.path.exists(build):
        os.makedirs(build)

    if not os.path.exists(build + "/image"):
        os.makedirs(build + "/image")

    if not os.path.exists(build + "/image/meta"):
        os.makedirs(build + "/image/meta")

    if not os.path.exists(build + "/image/fs"):
        os.makedirs(build + "/image/fs")


    # This script should copy the files to $(BUILD)/image/fs
    os.system("sh " + source + "/build.sh ")

    meta = toml.load(source + "/meta/Meta.toml")

    for key in meta:
        with open(build + "/image/meta/" + key, "w") as f:
            f.write(str(meta[key])+"\n")


    shutil.copy(build + "/tmp/version", build + "/image/meta/SPversion")
    shutil.copy(build + "/tmp/commit", build + "/image/meta/commit")
    shutil.copy("build.txt", build + "/image/meta/build")
    shutil.copy("syspatch/src/image/patch.sh", build + "/image/patch.sh")

    with tarfile.open(build + "/patch.tar.gz", "w:gz") as tar:
        tar.add(build + "/image", arcname="")
    
    with tarfile.open(build + "/patch.tar", "w") as tar:
        tar.add(build + "/image", arcname="")

    print("Patch created at " + build + "/patch.tar.gz")

    print("Now run: tar -xf patch.tar.gz && sh patch.sh")
if __name__ == "__main__":
    main()