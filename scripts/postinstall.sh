#!/bin/sh

echo 'Running post-install..'

echo 'Setting up pkg'
if [ ! -f /usr/local/sbin/pkg ]; then
	env ASSUME_ALWAYS_YES=yes pkg bootstrap
fi

echo 'Setting up VM Tools..'
if [ "$PACKER_BUILDER_TYPE" = 'vmware-iso' ]; then
	pkg install -y open-vm-tools-nox11
	echo 'vmware_guest_vmblock_enable="YES"' >> /etc/rc.conf
	echo 'vmware_guest_vmhgfs_enable="YES"' >> /etc/rc.conf
	echo 'vmware_guest_vmmemctl_enable="YES"' >> /etc/rc.conf
	echo 'vmware_guest_vmxnet_enable="YES"' >> /etc/rc.conf
	echo 'vmware_guestd_enable="YES"' >> /etc/rc.conf
elif [ "$PACKER_BUILDER_TYPE" = 'virtualbox-iso' ]; then
	pkg install -y virtualbox-ose-additions
else
	echo 'Unknown type of VM, not installing tools..'
fi

echo
echo 'Setting up sudo..'
pkg install -y sudo
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /usr/local/etc/sudoers

echo
echo 'Setting up the vagrant ssh keys'
pkg install -y curl
mkdir ~vagrant/.ssh
chmod 700 ~vagrant/.ssh
curl -skL -o ~vagrant/.ssh/authorized_keys http://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub
chown -R vagrant ~vagrant/.ssh
chmod 600 ~/vagrant/.ssh/authorized_keys

echo
echo 'Changing roots shell back'
chsh -s csh root

# This causes a hang on shutdown that we cannot automatically recover from
#echo 'Patching FreeBSD..'
#freebsd-update fetch install > /dev/null

echo
echo 'Post-install complete.'