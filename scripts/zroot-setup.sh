#!/bin/sh

echo
echo 'Setting up zroot..'

zfs set logbias=throughput zroot

echo
echo 'zroot setup complete.'
