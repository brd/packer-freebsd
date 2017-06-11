FreeBSD 11.X Packer Images
==========================

11.1
----

``FreeBSD-11.1-PRERELEASE-amd64-20170525-r318893``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Supported builders:

- ``vmware_fusion``::

    $ cd 11/ # This directory
    $ make 11.1-20170519-zfs PROVIDER=vmware-iso # EXTRA_OPTS="-var headless=false -debug"
    $ vagrant box add --name FreeBSD-11.1-PRERELEASE-zfs-20170525-r318893-vmware --provider=vmware_desktop FreeBSD-11.1-PRERELEASE-zfs-20170525-r318893-vmware.box
    $ cd ~/src/FreeBSD/my-work-dir # Must be in a different directory to run `vagrant init`
    $ vagrant init -m FreeBSD-11.1-PRERELEASE-zfs-20170525-r318893-vmware
    $ vagrant init --output Vagrantfile.example FreeBSD-11.1-PRERELEASE-zfs-20170525-r318893-vmware
    $ vagrant up --provider=vmware_fusion --destroy-on-error
    $ vagrant ssh
    $ vagrant suspend
    $ vagrant destroy
    $ vagrant box remove FreeBSD-11.1-PRERELEASE-zfs-20170525-r318893-vmware

- ``virtualbox``:

  Coming soon(tm).  It may just work.  Testers wanted.


11.0
----

``FreeBSD-11.0-STABLE-zfs-20170510-r318134``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Supported builders:

- ``vmware_fusion``::

    $ cd 11/ # This directory
    $ make 11.0-20170510-zfs PROVIDER=vmware-iso # EXTRA_OPTS="-var headless=false -debug"
    $ vagrant box add --name FreeBSD-11.0-STABLE-zfs-20170510-r318134-vmware --provider=vmware_desktop FreeBSD-11.0-STABLE-zfs-20170510-r318134-vmware.box
    $ cd ~/src/FreeBSD/my-work-dir # Must be in a different directory to run `vagrant init`
    $ vagrant init FreeBSD-11.0-STABLE-zfs-20170510-r318134-vmware
    $ vagrant up --provider=vmware_fusion --destroy-on-error
    $ vagrant ssh
    $ vagrant suspend
    $ vagrant destroy
    $ vagrant box remove FreeBSD-11.0-STABLE-zfs-20170510-r318134-vmware

- ``virtualbox``:

  Coming soon(tm).  It may just work.  Testers wanted.
