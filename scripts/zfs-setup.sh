#!/bin/sh

set -e

echo
echo 'Setting up ZFS...'

# It's a VM, ignore fsync(2)
echo ' * Changing logbias on zroot...'
/sbin/zfs set logbias=throughput zroot

echo ' * Updating /boot/loader.conf...'
cat <<'EOF' >> /boot/loader.conf
vfs.zfs.arc_max="40M"
vfs.zfs.vdev.cache.size="5M"
vm.kmem_size="200M"
vm.kmem_size_max="200M"
virtio_console_load="YES"
EOF

echo ' * Reserving space (~85%) of zroot'
/sbin/zfs set quota=`/sbin/zfs get -Hp available zroot | /usr/bin/awk '{print $3 * 0.85}'` zroot

echo
echo ' * Scheduling initial zpool scrub'
/sbin/zpool scrub zroot

echo
echo 'ZFS setup complete.'
