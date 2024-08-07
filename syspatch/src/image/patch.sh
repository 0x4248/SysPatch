# SPDX-License-Identifier: GPL-3.0
# SysPatch
# A simple patching system for Linux
#
# syspatch/src/image/patch.sh
#
# Copyright (C) 2024 0x4248


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