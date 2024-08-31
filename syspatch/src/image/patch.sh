# SPDX-License-Identifier: GPL-3.0
# SysPatch
# A simple tool to create and apply patches to a system.
#
# syspatch/src/image/patch.sh
#
# GNU General Public License v3.0
# Copyright (C) 2024 0x4248

echo -e "SysPatch $(cat meta/SPversion) $(cat meta/commit) #$(cat meta/build)"
echo -e "Patching system ($(uname -n)) with path $(cat meta/name)"
echo -e "[ SYSPATCH ]\tPatching"
cd fs
cp -r * /
cd ..
echo -e "[ SYSPATCH ]\tInstalling configuration files"
mkdir /tmp/syspatch
cd meta
cp -r * /tmp/syspatch
cd ..
echo -e "[ SYSPATCH ]\tCleaning up"
rm -rf fs meta

if [ -f /etc/syspatch/reboot ]; then
    echo -e "[ SYSPATCH ]\tChecking for reboot"
    if [ "$(cat /tmp/syspatch/reboot)" = "True" ]; then
        rm -rf /tmp/syspatch
        echo -e "[ SYSPATCH ]\tRebooting"
        reboot
    fi
fi

rm -rf /tmp/syspatch
echo -e "[ SYSPATCH ]\tDone"