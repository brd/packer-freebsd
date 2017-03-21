#!/bin/sh --

set -e

echo 'Running post-install..'

echo 'Disabling jemalloc(3) debugging...'
ln -sf 'abort:false,junk:false' /etc/malloc.conf
echo

echo 'Updating /boot/loader.conf...'
echo '  * Disabling Beastie boot screen'
cat <<'EOF' >> /boot/loader.conf
beastie_disable="YES"
kern.hz=50
EOF

# Configure fetch(3)
export FETCH_RETRY=5
export FETCH_TIMEOUT=30

echo 'Bootstrapping pkg(1)...'
ASSUME_ALWAYS_YES=yes pkg bootstrap

echo 'Update the pkg database...'
pkg update

echo 'Upgrade pkg database...'
pkg upgrade -n

echo 'Initializing the pkg audit database...'
pkg audit -F

echo 'Setting up VM Tools...'
printf "Packer Builder Type: %s\n" "${PACKER_BUILDER_TYPE}"
if [ "$PACKER_BUILDER_TYPE" = 'vmware-iso' ]; then
	pkg install -y open-vm-tools-nox11
	sysrc vmware_guest_vmblock_enable=YES
	sysrc vmware_guest_vmmemctl_enable=YES

        # Disable vmxnet in favor of whatever the OpenVM Tools are suggesting
	sysrc vmware_guest_vmxnet_enable=YES
        sed -i -e 's#^ifconfig_vmx0#ifconfig_em0#g' /etc/rc.conf
        sed -i -e '/^if_vmx_load=.*/d' /boot/loader.conf

	sysrc vmware_guestd_enable=YES
elif [ "$PACKER_BUILDER_TYPE" = 'virtualbox-iso' ]; then
	pkg install -y virtualbox-ose-additions
	sysrc ifconfig_em1="inet 10.6.66.42 netmask 255.255.255.0"
	sysrc vboxguest_enable="YES"
        sysrc vboxservice_flags="--disable-timesync"
	sysrc vboxservice_enable="YES"
else
	echo 'Unknown type of VM, not installing tools...'
fi

# echo
# echo 'Installing doas...'
# pkg install -y doas
# echo "permit nopass :wheel" >> /etc/doas.conf
# cat <<'EOF' >> /etc/syslog.conf
# #!doas
# #*.*/var/log/doas
# EOF
# touch /var/log/doas
# chmod 0600 /var/log/doas

echo
echo 'Setting up sudo...'
pkg install -y sudo
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /usr/local/etc/sudoers.d/vagrant

echo
echo 'Setting up the vagrant ssh keys...'
mkdir -p ~vagrant/.ssh
chmod 0700 ~vagrant/.ssh
cat <<'EOF' > ~vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
EOF
chown -R vagrant ~vagrant/.ssh
chmod 0600 ~vagrant/.ssh/authorized_keys

echo
echo 'Changing roots shell back...'
chsh -s tcsh root

# This causes a hang on shutdown that we cannot automatically recover from
#echo 'Patching FreeBSD...'
#freebsd-update fetch install > /dev/null

echo
echo 'Updating locate(1) database...'
/etc/periodic/weekly/310.locate

echo
echo 'Post-install complete.'
