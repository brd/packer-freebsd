# FreeBSD Packer template

Creates a vagrant box for FreeBSD 10.1-RELEASE.

Run using `packer build template.json`

Add resultant vagrant boxes using:
 * `vagrant box add FreeBSD-10.1 FreeBSD-10.1-RELEASE-virtualbox.box`
 * `vagrant box add FreeBSD-10.1 FreeBSD-10.1-RELEASE-vmware.box`

Initialize vagrant using `vagrant init --minimal FreeBSD-10.1`

Notes:

 * The VM is set to have 1024MB of RAM and a 20GB drive
 * When bringing vagrant boxes up for the first time, you will
   need sudo privlidges to add entries in /etc/exports to allow
   vagrant to mount /vagrant in the guest.  See 
   [Vagrant NFS syned folders](https://docs.vagrantup.com/v2/synced-folders/nfs.html)
