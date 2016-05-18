# FreeBSD Packer template

Prerequisites for using either the `10.1-RELEASE` or `-CURRENT` boxes:

 * Install [Vagrant](https://www.vagrantup.com)
 * Install [Packer](https://www.packer.io/)
 * Clone this repo onto your machine

To create a Vagrant box for FreeBSD `10.1-RELEASE` (`r276981`):

 * Build the Vagrant box with: `packer build template-10.1.json`
 * Wait.
 * Add the appropriate Vagrant box for your system.  For example, on VMware:
   `vagrant box add --name FreeBSD-10.1 FreeBSD-10.1-RELEASE-vmware.box`

To create a Vagrant box for `-CURRENT` (as of `20160429-r298793`):

 * Build using `./automatic-current-{ufs,zfs}.sh`
   * This will autodetect the latest `-CURRENT` snapshot, pull it, and apply
     the Packer Template.  NOTE: THIS MAY FAIL ON NEWER BUILDS.
   * To build only `vmware-iso` or `virtualbox`, pass `-only
     {virtualbox,vmware-iso}` to `automatic-current-{ufs,zfs}.sh`.
   * In the event of a failed build, change `headless` to true in
     `template-current-{ufs,zfs}.json` and re-run with the `-debug` flag to
     step through Packer's `boot_command`'s (normally only required when
     `bsdinstall` changes).
 * Add the appropriate Vagrant box for your system.  For example, on
   `{VirtualBox,VMware}` with a `{UFS,ZFS}` root filesystem: `vagrant box add --name FreeBSD-CURRENT-{ufs,zfs}-20160429-r298793 FreeBSD-CURRENT-{ufs,zfs}-20160429-r298793-{virtualbox,vmware}.box`

Vagrant primer:

 * Initialize Vagrant using: `vagrant init --minimal <box name>`
 * Initialize Vagrant using `vmware_fusion`: `vagrant up --provider=vmware_fusion`
 * Start the Vagrant VM: `vagrant up`
 * Connect to the VM: `vagrant ssh`
 * Hack away (tip: `cd /vagrant` assuming `nfsd` is running on the host)
 * Suspend the Vagrant VM: `vagrant suspend`
 * Destroy a suspended VM: `vagrant destroy`
 * See all images: `vagrant global-status`

Notes:

 * The VM is set to have 1024MB of RAM and a 20GB drive
 * When bringing Vagrant boxes up for the first time, you will need `sudo`
   privileges on the host machine (i.e. your laptop) to add entries to
   `/etc/exports` in order to allow Vagrant to mount `/vagrant` in the guest.
   See
   [Vagrant NFS synced folders](https://docs.vagrantup.com/v2/synced-folders/nfs.html)
