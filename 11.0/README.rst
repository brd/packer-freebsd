FreeBSD 11.X Packer Images
==========================

11.0
----

``FreeBSD-11.0-STABLE-zfs-20170316-r315416``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Supported builders:

- ``vmware_fusion``

::

    $ cd 11.0/ # This directory
    $ packer build -only=vmware-iso -var boot_wait=35s amd64-20170316-r315416-zfs.json
    $ vagrant box add --name FreeBSD-11.0-STABLE-zfs-20170316-r315416-vmware FreeBSD-11.0-STABLE-zfs-20170316-r315416-vmware.box
    $ vagrant init FreeBSD-11.0-STABLE-zfs-20170316-r315416-vmware
    $ vagrant up --provider=vmware_fusion
    $ vagrant destroy
    $ vagrant box remove FreeBSD-11.0-STABLE-zfs-20170316-r315416-vmware

- ``virtualbox``

  Coming soon(tm).
