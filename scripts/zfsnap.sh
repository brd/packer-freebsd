#!/bin/sh --
set -e
echo "Beginning sysutils/zfsnap2 installation..."
sudo env ASSUME_ALWAYS_YES=yes pkg install -y sysutils/zfsnap2
cat <<'EOF' | sudo tee -a /etc/periodic.conf
hourly_zfsnap_delete_enable="YES"
hourly_zfsnap_delete_verbose="YES"
hourly_zfsnap_enable="YES"
hourly_zfsnap_flags="-s -S"
hourly_zfsnap_recursive_fs="zroot/ROOT zroot/usr zroot/var"
daily_zfsnap_delete_enable="YES"
daily_zfsnap_delete_flags="-s -S"
daily_zfsnap_delete_verbose="YES"
daily_zfsnap_enable="YES"
daily_zfsnap_recursive_fs="zroot/ROOT zroot/usr"
EOF
cat <<'EOF' | sudo tee -a /etc/crontab
4        *       *       *       *       root    periodic hourly
*/5      *       *       *       *       root    /usr/local/sbin/zfsnap snapshot -a 24h -r zroot/usr
@reboot                                  root    periodic reboot
EOF
echo "sysutils/zfsnap2 installation complete."
