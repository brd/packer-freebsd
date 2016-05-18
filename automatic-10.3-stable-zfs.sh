#!/bin/sh
# Autodetect the current version of -STABLE on freebsd.org.
# This assumes the template boot command is still valid.
# Any arguments are passed to the packer instance.

. stable.subr

exec \
packer build \
	-var "iso_daterev=${rev}" \
	-var "iso_checksum=${cksum}" \
	-var "iso_checksum_type=${CHECKSUM_TYPE}" \
	$* \
	template-10.3-stable-zfs.json
