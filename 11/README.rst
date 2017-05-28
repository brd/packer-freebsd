FreeBSD 11.X Packer Images
==========================

11.0
----

``FreeBSD-11.0-STABLE-zfs-20170510-r318134``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Supported builders:

- ``vmware_fusion``

::

    $ cd 11/ # This directory
    $ make 20170510-zfs TARGET=vmware-iso # EXTRA_OPTS="-var headless=false -debug"
    $ vagrant box add --name FreeBSD-11.0-STABLE-zfs-20170510-r318134-vmware --provider=vmware_desktop FreeBSD-11.0-STABLE-zfs-20170510-r318134-vmware.box
    $ cd ~/src/FreeBSD/my-work-dir # Must be in a different directory to run `vagrant init`
    $ vagrant init FreeBSD-11.0-STABLE-zfs-20170510-r318134-vmware
    $ vagrant up --provider=vmware_fusion
    $ vagrant ssh
    $ vagrant suspend
    $ vagrant destroy
    $ vagrant box remove FreeBSD-11.0-STABLE-zfs-20170510-r318134-vmware

- ``virtualbox``

  Coming soon(tm).

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
There is a [bug in Vagrant that prevents NFS shared folders from
working](https://github.com/mitchellh/vagrant/issues/8624).  Type `make
patch-vagrant-nfs` to apply a patch to workaround this bug.
