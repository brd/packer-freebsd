#!/bin/sh --

echo
echo 'Setting up UFS...'

echo 'fsck(1) to protect against unclean shutdowns'
sysrc fsck_y_enable="YES"

echo
echo 'UFS setup complete.'
