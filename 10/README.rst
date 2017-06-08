FreeBSD 10.X Packer Images
==========================

10.3
----

``FreeBSD-10.3-STABLE-amd64-20170602-r319484``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Supported builders:

- ``vmware_fusion``::

    $ cd 10/ # This directory
    $ make 10.3-20170607-zfs PROVIDER=virtualbox-iso EXTRA_OPTS="-var headless=false -debug"
    $ vagrant box add --name FreeBSD-10.3-STABLE-zfs-20170602-r319484-vmware --provider=vmware_desktop FreeBSD-10.3-STABLE-zfs-20170602-r319484-vmware.box
    $ cd ~/src/FreeBSD/my-work-dir # Must be in a different directory to run `vagrant init`
    $ vagrant init -m FreeBSD-10.3-STABLE-zfs-20170602-r319484-vmware
    $ vagrant init --output Vagrantfile.example FreeBSD-10.3-STABLE-zfs-20170602-r319484-vmware
    $ vagrant up --provider=vmware_fusion
    $ vagrant ssh
    $ vagrant suspend
    $ vagrant destroy
    $ vagrant box remove FreeBSD-10.3-STABLE-zfs-20170602-r319484-vmware

- ``virtualbox``::

    $ cd 10/ # This directory
    $ make 10.3-20170607-zfs PROVIDER=virtualbox-iso EXTRA_OPTS="-var headless=false -debug"
    $ vagrant box add --name FreeBSD-10.3-STABLE-zfs-20170602-r319484-virtualbox --provider=virtualbox FreeBSD-10.3-STABLE-zfs-20170602-r319484-virtualbox.box
    $ cd ~/src/FreeBSD/my-work-dir # Must be in a different directory to run `vagrant init`
    $ vagrant init -m FreeBSD-10.3-STABLE-zfs-20170602-r319484-virtualbox
    $ vagrant init --output Vagrantfile.example FreeBSD-10.3-STABLE-zfs-20170602-r319484-virtualbox
    $ vagrant up --provider=virtualbox
    $ vagrant ssh
    $ vagrant suspend
    $ vagrant destroy
    $ vagrant box remove FreeBSD-10.3-STABLE-zfs-20170602-r319484-virtualbox

