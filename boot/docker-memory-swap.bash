#!/usr/bin/env bash 

cat <<-Doc
On systems using GRUB (which is the default for Ubuntu), you can add those parameters by editing /etc/default/grub and extending GRUB_CMDLINE_LINUX. Look for the following line:

GRUB_CMDLINE_LINUX=""

And replace it by the following one:

GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"

Then run sudo update-grub, and reboot.

These parameters will help you get rid of the following warnings:

WARNING: Your kernel does not support cgroup swap limit.
WARNING: Your kernel does not support swap limit capabilities. Limitation discarded.
Doc
