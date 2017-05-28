FreeBSD 11.X Packer Images
==========================

11.1
----

``FreeBSD-11.1-PRERELEASE-amd64-20170525-r318893``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Supported builders:

- ``vmware_fusion``

::

    $ cd 11/ # This directory
    $ make 11.1-20170519-zfs TARGET=vmware-iso # EXTRA_OPTS="-var headless=false -debug"
    $ vagrant box add --name FreeBSD-11.1-PRERELEASE-zfs-20170525-r318893-vmware --provider=vmware_desktop FreeBSD-11.1-PRERELEASE-zfs-20170525-r318893-vmware.box
    $ cd ~/src/FreeBSD/my-work-dir # Must be in a different directory to run `vagrant init`
    $ vagrant init -m FreeBSD-11.1-PRERELEASE-zfs-20170525-r318893-vmware
    $ vagrant init --output Vagrantfile.example FreeBSD-11.1-PRERELEASE-zfs-20170525-r318893-vmware
    $ vagrant up --provider=vmware_fusion
    $ vagrant ssh
    $ vagrant suspend
    $ vagrant destroy
    $ vagrant box remove FreeBSD-11.1-PRERELEASE-zfs-20170525-r318893-vmware

- ``virtualbox``

  Coming soon(tm).  It may just work.  Testers wanted.


11.0
----

``FreeBSD-11.0-STABLE-zfs-20170510-r318134``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Supported builders:

- ``vmware_fusion``

::

    $ cd 11/ # This directory
    $ make 11.0-20170510-zfs TARGET=vmware-iso # EXTRA_OPTS="-var headless=false -debug"
    $ vagrant box add --name FreeBSD-11.0-STABLE-zfs-20170510-r318134-vmware --provider=vmware_desktop FreeBSD-11.0-STABLE-zfs-20170510-r318134-vmware.box
    $ cd ~/src/FreeBSD/my-work-dir # Must be in a different directory to run `vagrant init`
    $ vagrant init FreeBSD-11.0-STABLE-zfs-20170510-r318134-vmware
    $ vagrant up --provider=vmware_fusion
    $ vagrant ssh
    $ vagrant suspend
    $ vagrant destroy
    $ vagrant box remove FreeBSD-11.0-STABLE-zfs-20170510-r318134-vmware

- ``virtualbox``

  Coming soon(tm).  It may just work.  Testers wanted.

``FreeBSD-11.0-STABLE-zfs-20170323-r315855``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Supported builders:

- ``vmware_fusion``

::

    $ cd 11/ # This directory
    $ packer build -only=vmware-iso -var boot_wait=35s amd64-20170323-r315855-zfs.json
    $ vagrant box add --name FreeBSD-11.0-STABLE-zfs-20170323-r315855-vmware --provider=vmware_desktop FreeBSD-11.0-STABLE-zfs-20170323-r315855-vmware.box
    $ vagrant init FreeBSD-11.0-STABLE-zfs-20170323-r315855-vmware
    $ vagrant up --provider=vmware_fusion
    $ vagrant ssh
    $ vagrant suspend
    $ vagrant destroy
    $ vagrant box remove FreeBSD-11.0-STABLE-zfs-20170323-r315855-vmware

- ``virtualbox``

  Coming soon(tm).

``FreeBSD-11.0-STABLE-zfs-20170316-r315416``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Supported builders:

- ``vmware_fusion``

::

    $ cd 11/ # This directory
    $ packer build -only=vmware-iso -var boot_wait=35s amd64-20170316-r315416-zfs.json
    $ vagrant box add --name FreeBSD-11.0-STABLE-zfs-20170316-r315416-vmware --provider=vmware_desktop FreeBSD-11.0-STABLE-zfs-20170316-r315416-vmware.box
    $ vagrant init FreeBSD-11.0-STABLE-zfs-20170316-r315416-vmware
    $ vagrant up --provider=vmware_fusion
    $ vagrant ssh
    $ vagrant suspend
    $ vagrant destroy
    $ vagrant box remove FreeBSD-11.0-STABLE-zfs-20170316-r315416-vmware

- ``virtualbox``

  Coming soon(tm).

Vagrant Notes
^^^^^^^^^^^^^

- Install sudo(8) command specs for NFS shared folders.  Type `make
  install-nfs-mac`.

- Vagrant NFS Shared Folders: There is a [bug in Vagrant that prevents NFS
  shared folders from
  working](https://github.com/mitchellh/vagrant/issues/8624).  Type `make
  patch-vagrant` to apply a patch to workaround this bug.