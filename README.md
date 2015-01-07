# FreeBSD Packer template

To create a vagrant box for FreeBSD 10.1-RELEASE:

 * Install [Vagrant](https://www.vagrantup.com)
 * Install [Packer](https://www.packer.io/)
 * Clone this repo onto your machine
 * Build the Vagrant box with: `packer build template.json`
 * Wait..
 * Add one of the resultant vagrant boxes using:
   * VirtualBox `vagrant box add FreeBSD-10.1 FreeBSD-10.1-RELEASE-virtualbox.box`
   * VMware `vagrant box add FreeBSD-10.1 FreeBSD-10.1-RELEASE-vmware.box`
 * Start the Vagrant VM: `vagrant up`
 * Connect to the VM: `vagrant ssh`
 * Hack away

Initialize vagrant using `vagrant init --minimal FreeBSD-10.1`

Notes:

 * The VM is set to have 1024MB of RAM and a 20GB drive
 * When bringing vagrant boxes up for the first time, you will
   need sudo privlidges to add entries in /etc/exports to allow
   vagrant to mount /vagrant in the guest.  See 
   [Vagrant NFS syned folders](https://docs.vagrantup.com/v2/synced-folders/nfs.html)
