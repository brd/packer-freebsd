FreeBSD 12.X Packer Images
==========================

12.0
----

``FreeBSD-12.0-CURRENT-amd64-20170526-r318945``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Supported builders:

- ``vmware_fusion``::

    $ cd 12/ # This directory
    $ make 12.0-20170526-zfs TARGET=vmware-iso # EXTRA_OPTS="-var headless=false -debug"
    $ vagrant box add --name FreeBSD-12.0-CURRENT-zfs-20170526-r318945-vmware --provider=vmware_desktop FreeBSD-12.0-CURRENT-zfs-20170526-r318945-vmware.box
    $ cd ~/src/FreeBSD/my-work-dir # Must be in a different directory to run `vagrant init`
    $ vagrant init -m FreeBSD-12.0-CURRENT-zfs-20170526-r318945-vmware
    $ vagrant init --output Vagrantfile.example FreeBSD-12.0-CURRENT-zfs-20170526-r318945-vmware
    $ vagrant up --provider=vmware_fusion
    $ vagrant ssh
    $ vagrant suspend
    $ vagrant destroy
    $ vagrant box remove FreeBSD-12.0-CURRENT-zfs-20170526-r318945-vmware

- ``virtualbox``:

  Coming soon(tm).  It may just work.  Testers wanted.
