# FreeBSD Packer Templates

Creates FreeBSD images using official `disk1.iso` snapshot and release media.

Images supported:
  * VMware Fusion + Vagrant
  * Virtualbox + Vagrant

Prerequisites:
 * Install [Vagrant](https://www.vagrantup.com)
 * Install [Packer](https://www.packer.io/)
 * Clone this repo onto your machine

Common Workflow:

```sh
% ./automatic-10.3-stable-zfs.sh
% vagrant up
% vagrant ssh
% vagrant suspend
```

## FreeBSD `10.3-RELEASE`

```sh
% packer build template-10.3-release-ufs.json
% packer build template-10.3-release-zfs.json
```

After downloading the ISO, this step takes ~6min per image (e.g. VMware ZFS
image).

To limit the build to just VMware or Virtualbox, pass the argument
`-only=vmware-iso` or `-only=virtualbox` to `packer`.

## FreeBSD `10.3-STABLE`

To create a Vagrant box for FreeBSD `10.3-STABLE` (`20160429-r298781`) using
a UFS or ZFS filesystem:

```sh
./automatic-10.3-stable-ufs.sh
./automatic-10.3-stable-zfs.sh
```



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

## Debugging Builds

The following are "common" problems with workarounds:

1. Packer fails because the `bsdinstall` menus have changed when building a
   `-current` or `-stable` image.  Solution: Change `"headless": "true"` to
   `"false"`, add the `-debug` flag to `packer build` and submit a patch
   fixing the menu change.

2. Packer fails to connect via SSH to the instance to do the post-install.
   Possible solution: There are too many SSH keys loaded in your agent.
   Prefix your command with `env SSH_AUTH_SOCK=/dev/null ...`
