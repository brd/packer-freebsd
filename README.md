# FreeBSD Packer Templates

Creates FreeBSD images using official `disk1.iso` snapshot and release media.

Common Workflow:
```sh
% ./automatic-10.3-stable-zfs.sh -only=vmware-iso
% vagrant up
% vagrant ssh
% vagrant suspend
```

Images supported:
* VMware Fusion + Vagrant
* Virtualbox + Vagrant

Prerequisites:
* Install [Vagrant](https://www.vagrantup.com)
* Install [Packer](https://www.packer.io/)
* Clone this repo onto your machine

Notes:
* The VM is set to have 1024MB of RAM and a 20GB drive
* When bringing Vagrant boxes up for the first time, you will need `sudo`
  privileges on the host machine (i.e. your laptop) to add entries to
  `/etc/exports` in order to allow Vagrant to mount `/vagrant` in the guest.
  See
  [Vagrant NFS synced folders](https://docs.vagrantup.com/v2/synced-folders/nfs.html)
* To limit the build to just VMware or Virtualbox, pass the argument
  `-only=vmware-iso` or `-only=virtualbox` to either `packer build` or the
  `automatic-*` scripts mentioned below.

## FreeBSD `11.0-ALPHA4`

To create a Vagrant box for `11.0-ALPHA4` using ZFS as a root filesystem:

```sh
% packer build -only={vmware-iso,virtualbox-iso} template-11.0-alpha4-zfs.json
```

Remove the `-only=` argument if you want to build both `vmware-iso` and
`virtualbox-iso` Boxes.

## FreeBSD `11.0-CURRENT`

To create a Vagrant box for `11.0-CURRENT` (as of `20160518-r300097`) using a
UFS or ZFS filesystem:

```sh
% ./automatic-11.0-current-ufs.sh
% ./automatic-11.0-current-zfs.sh
```

## FreeBSD `10.3-STABLE`

To create a Vagrant box for FreeBSD `10.3-STABLE` (`20160518-r300092`) using
a UFS or ZFS filesystem:

```sh
% ./automatic-10.3-stable-ufs.sh
% ./automatic-10.3-stable-zfs.sh
```

## FreeBSD `10.3-RELEASE`

To create a Vagrant box for FreeBSD `10.3-RELEASE` using a UFS or ZFS
filesystem:

```sh
% packer build template-10.3-release-ufs.json
% packer build template-10.3-release-zfs.json
```

After downloading the ISO, this step takes ~6min per image (e.g. VMware ZFS
image).

## `automatic-*` Script Notes

* To build only `vmware-iso` or `virtualbox-iso`, pass `-only=virtualbox-iso`
  or `-only=vmware-iso` to the script, which will forward the flag to `packer
  build`.  Omitting an `-only` argument will result in Packer building all
  available providers.
* This will autodetect the latest snapshot, pull it, and apply the Packer
  Template.
* Builds may suddenly fail if `bsdinstall` has its menu changed (see the
  [Debugging Builds](#debugging-builds) section below)

## Vagrant Primer

* Initialize Vagrant using: `vagrant init --minimal <box name>`
* Initialize Vagrant using `vmware_fusion`: `vagrant up --provider=vmware_fusion`
* Start the Vagrant VM: `vagrant up`
* Connect to the VM: `vagrant ssh`
* Hack away (tip: `cd /vagrant` assuming `nfsd` is running on the host)
* Suspend the Vagrant VM: `vagrant suspend`
* Destroy a suspended VM: `vagrant destroy`
* See all images: `vagrant global-status`
* Add the appropriate Vagrant box for your system.  For example, on VMware:
  `vagrant box add --name FreeBSD-11.0-CURRENT-ufs-20160518-r300097 FreeBSD-11.0-CURRENT-ufs-20160518-r300097-virtualbox.box`

## Debugging Builds

The following are "common" problems with workarounds:

1. Packer fails because the `bsdinstall` menus have changed when building a
   `-current` or `-stable` image.  Solution: Change `"headless": "true"` to
   `"false"`, add the `-debug` flag to `packer build` and submit a patch
   fixing the menu change.

2. Packer fails to connect via SSH to the instance to do the post-install.
   Possible solution: There are too many SSH keys loaded in your agent.
   Prefix your command with `env SSH_AUTH_SOCK=/dev/null ...`
