#!/bin/sh
# Autodetect the current version of -CURRENT on freebsd.org.
# This assumes the template boot command is still valid.
# Any arguments are passed to the packer instance.

. current.subr

exec \
packer build \
	-var "iso_daterev=${rev}" \
	-var "iso_checksum=${cksum}" \
	-var "iso_checksum_type=${CHECKSUM_TYPE}" \
	$* \
	template-11.0-current-zfs.json
