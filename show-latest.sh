#!/bin/sh --
#
# Usage: $0 [version [arch]]

set -eu

ARCH=amd64
ISO_VERSION=11.1

if [ $# -gt 0 ]; then
    ISO_VERSION=$1
    shift
fi

if [ $# -gt 0 ]; then
    ARCH=$1
    shift
fi

LISTING_URL="ftp://ftp.FreeBSD.org/pub/FreeBSD/snapshots/ISO-IMAGES/${ISO_VERSION}/"
DOWNLOAD_URL="https://download.FreeBSD.org/ftp/snapshots/ISO-IMAGES/${ISO_VERSION}/"

# Valid values are "none", "md5", "sha1", "sha256", or "sha512".
CHECKSUM_TYPE="sha512"

error() {
	echo "$0: ERROR: $1"
	[ -n "$2" ] && echo "$2"
	exit 1
}

which curl >/dev/null 2>&1 || error "curl(1) required, but not available or in PATH"

cksumfile=$(curl -sl ${LISTING_URL} | grep -i "${CHECKSUM_TYPE}" | grep "${ARCH}" | sort | tail -1)
[ -z "$cksumfile" ] && error "Could not detect the latest checksum file"

cksumline=$(curl -so - ${DOWNLOAD_URL}${cksumfile} | grep 'disc1\.iso)')
[ -z "$cksumline" ] && error "Could not pull the latest checksum file"

isofile=$(echo $cksumline | awk -F\( '{print $2}' | awk -F\) '{print $1}')
cksum=$(echo $cksumline | awk '{print $4}')

[ -z "$isofile" -o -z "$cksum" ] && \
	error "Pulled latest checksum file, but could not parse line:" \
	    "  $cksumline"

rev=$(echo $isofile | awk -Famd64- '{print $2}' | awk -F-disc1.iso '{print $1}')
[ -z "$rev" ] && error \
	"Could not detect ISO date/revision in '${isofile}':" \
	"  $cksumline"

echo "arch: ${ARCH}"
echo "checksum_url: ${DOWNLOAD_URL}${cksumfile}"
echo "iso_checksum: ${cksum}"
echo "iso_filename: ${isofile}"
echo "iso_url: ${DOWNLOAD_URL}$isofile"
echo "iso_version: ${ISO_VERSION}"
