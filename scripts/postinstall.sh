#!/bin/sh --

set -e

echo 'Running post-install..'

echo 'Updating /boot/loader.conf...'
echo '  * Disabling Beastie boot screen'
cat <<'EOF' >> /boot/loader.conf
beastie_disable="YES"
EOF

echo 'Bootstrapping pkg(1)...'
ASSUME_ALWAYS_YES=yes pkg bootstrap -f

echo 'Initializing the pkg audit database...'
pkg audit -F

echo 'Setting up VM Tools...'
printf "Packer Builder Type: %s\n" "${PACKER_BUILDER_TYPE}"
if [ "$PACKER_BUILDER_TYPE" = 'vmware-iso' ]; then
	pkg install -y open-vm-tools-nox11
	sysrc vmware_guest_vmblock_enable=YES
	sysrc vmware_guest_vmhgfs_enable=YES
	sysrc vmware_guest_vmmemctl_enable=YES
	sysrc vmware_guest_vmxnet_enable=YES
	sysrc vmware_guestd_enable=YES
elif [ "$PACKER_BUILDER_TYPE" = 'virtualbox-iso' ]; then
	pkg install -y virtualbox-ose-additions
	sysrc ifconfig_em1="inet 10.6.66.42 netmask 255.255.255.0"
	sysrc vboxguest_enable="YES"
	sysrc vboxservice_enable="YES"
else
	echo 'Unknown type of VM, not installing tools...'
fi

echo
echo 'Setting up sudo...'
pkg install -y sudo
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /usr/local/etc/sudoers.d/vagrant

echo
echo 'Setting up the vagrant ssh keys...'
mkdir ~vagrant/.ssh
chmod 700 ~vagrant/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > ~vagrant/.ssh/authorized_keys
chown -R vagrant ~vagrant/.ssh
chmod 600 ~vagrant/.ssh/authorized_keys

echo
echo 'Changing roots shell back...'
chsh -s tcsh root

# This causes a hang on shutdown that we cannot automatically recover from
#echo 'Patching FreeBSD...'
#freebsd-update fetch install > /dev/null

echo
echo 'Post-install complete.'
