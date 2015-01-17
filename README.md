# FreeBSD Packer template

To create a vagrant box for FreeBSD 10.1-RELEASE or -CURRENT (r276981):

 * Install [Vagrant](https://www.vagrantup.com)
 * Install [Packer](https://www.packer.io/)
 * Clone this repo onto your machine
 * Build the Vagrant box with:
   * 10.1: `packer build template-10.1.json`
   * -CURRENT: `packer build template-current.json`
 * Wait.
 * Add the appropriate Vagrant box for your system.  For example:
   * VirtualBox CURRENT: `vagrant box add --name FreeBSD-CURRENT-r276981 FreeBSD-CURRENT-r276981-virtualbox.box`
   * VMware 10.1: `vagrant box add --name FreeBSD-10.1 FreeBSD-10.1-RELEASE-vmware.box`
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
