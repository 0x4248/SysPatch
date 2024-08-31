# SPDX-License-Identifier: GPL-3.0
# SysPatch
# A simple patching system for Linux
#
# extra/patch-UTM.sh
#
# GNU General Public License v3.0
# Copyright (C) 2024 0x4248

# cd build && python3 -m http.server 4522 && cd ..

curl -o patch.tar http://192.168.64.1:4522/patch.tar && tar -xf patch.tar && sh patch.sh && rm -f patch.sh patch.tar
