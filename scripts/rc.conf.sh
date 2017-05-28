#!/bin/sh --

set -e

echo
echo 'Setting up /etc/rc.conf...'

# Set dumpdev to "AUTO" to enable crash dumps, "NO" to disable
echo ' * dumpdev=NO'
sysrc dumpdev="NO"

# Rename vtnet* to em*
#sysrc ifconfig_vtnet0_name="em0"
#sysrc ifconfig_vtnet1_name="em1"
#sysrc ifconfig_em0="DHCP"
echo 'Done setting up /etc/rc.conf.'
echo
