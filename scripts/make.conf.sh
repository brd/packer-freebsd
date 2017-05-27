#!/bin/sh --

set -e

echo
echo 'Setting up make.conf(1)...'
echo ' * /etc/make.conf'
cat <<EOF >> /etc/make.conf
MALLOC_PRODUCTION= YES
EOF

echo ' * /etc/src.conf'
cat <<'EOF' >> /etc/src.conf
# Stuff we don't need for a headless VM
WITHOUT_BLUETOOTH= YES
WITHOUT_FLOPPY= YES
WITHOUT_GAMES= YES
WITHOUT_USB= YES
WITHOUT_WIRELESS= YES
WITHOUT_WPA_SUPPLICANT_EAPOL= YES
WITHOUT_NTP= YES # time sync is handled by VirtualBox
EOF

echo ' * /etc/ports.conf'
cat <<'EOF' >> /etc/ports.conf
# Stuff we don't need for a headless VM
WITHOUT_X11= YES
WITHOUT_GUI= YES
WITHOUT_CUPS= YES
EOF
echo 'make.conf(1) setup complete.'
echo
