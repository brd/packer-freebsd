#!/bin/sh

echo
echo 'Setting up zroot..'

# It's a VM, ignore fsync(2)
echo 'Changing logbias on zroot...'
/sbin/zfs set logbias=throughput zroot

echo 'Updating /boot/loader.conf...'
echo '  * Adjusting ZFS parameters'
cat <<'EOF' >> /boot/loader.conf
vfs.zfs.arc_max="40M"
vfs.zfs.vdev.cache.size="5M"
vm.kmem_size="330M"
vm.kmem_size_max="330M"
EOF

echo 'Reserving space (~85%) of zroot'
/sbin/zfs set quota=`/sbin/zfs get -Hp available zroot | /usr/bin/awk '{print $3 * 0.85}'` zroot

echo
echo 'Scheduling initial zpool scrub'
/sbin/zpool scrub zroot

echo
echo 'zroot setup complete.'
