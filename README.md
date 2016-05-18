# FreeBSD Packer template

Prerequisites for using either the 10.1-RELEASE or -CURRENT boxes:

 * Install [Vagrant](https://www.vagrantup.com)
 * Install [Packer](https://www.packer.io/)
 * Clone this repo onto your machine

To create a vagrant box for FreeBSD 10.1-RELEASE or -CURRENT (r276981):

 * Build the Vagrant box with: `packer build template-10.1.json`
 * Wait.
 * Add the appropriate Vagrant box for your system.  For example, on VMware:
   `vagrant box add --name FreeBSD-10.1 FreeBSD-10.1-RELEASE-vmware.box`

To create a vagrant box for -CURRENT:

 * Build using `./automatic-current.sh`
   * This will autodetect the latest -CURRENT snapshot, pull it, and apply
     the recipe.  NOTE: THIS MAY FAIL ON NEWER BUILDS.
 * Add the appropriate Vagrant box for your system.  For example, on VirtualBox:
   `vagrant box add --name FreeBSD-CURRENT-20160429-r298793 FreeBSD-CURRENT-20160429-r298793-virtualbox.box`

To use any Vagrant box:

 * Initialize vagrant using: `vagrant init --minimal <box name>`
 * Start the Vagrant VM: `vagrant up`
 * Connect to the VM: `vagrant ssh`
 * Hack away

Notes:

 * The VM is set to have 1024MB of RAM and a 20GB drive
 * When bringing vagrant boxes up for the first time, you will
   need sudo privileges to add entries in /etc/exports to allow
   vagrant to mount /vagrant in the guest.  See 
   [Vagrant NFS synced folders](https://docs.vagrantup.com/v2/synced-folders/nfs.html)
