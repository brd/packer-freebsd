FreeBSD 12.X Packer Images
==========================

12.0
----

``FreeBSD-12.0-CURRENT-amd64-20170602-r319481``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Supported builders:

- ``vmware_fusion``::

    $ cd 12/ # This directory
    $ make 12.0-20170602-zfs PROVIDER=vmware-iso # EXTRA_OPTS="-var headless=false -debug"
    $ vagrant box add --name FreeBSD-12.0-CURRENT-zfs-20170602-r319481-vmware --provider=vmware_desktop FreeBSD-12.0-CURRENT-zfs-20170602-r319481-vmware.box
    $ cd ~/src/FreeBSD/my-work-dir # Must be in a different directory to run `vagrant init`
    $ vagrant init -m FreeBSD-12.0-CURRENT-zfs-20170602-r319481-vmware
    $ vagrant init --output Vagrantfile.example FreeBSD-12.0-CURRENT-zfs-20170602-r319481-vmware
    $ vagrant up --provider=vmware_fusion --destroy-on-error
    $ vagrant ssh
    $ vagrant suspend
    $ vagrant destroy
    $ vagrant box remove FreeBSD-12.0-CURRENT-zfs-20170602-r319481-vmware

- ``virtualbox``::

    $ cd 12/ # This directory
    $ make 12.0-20170602-zfs PROVIDER=virtualbox-iso EXTRA_OPTS="-var headless=false -debug"
    $ vagrant box add --name FreeBSD-12.0-CURRENT-zfs-20170602-r319481-virtualbox --provider=virtualbox FreeBSD-12.0-CURRENT-zfs-20170602-r319481-virtualbox.box
    $ cd ~/src/FreeBSD/my-work-dir # Must be in a different directory to run `vagrant init`
    $ vagrant init -m FreeBSD-12.0-CURRENT-zfs-20170602-r319481-virtualbox
    $ vagrant init --output Vagrantfile.example FreeBSD-12.0-CURRENT-zfs-20170602-r319481-virtualbox
    $ vagrant up --provider=virtualbox --destroy-on-error
    $ vagrant ssh
    $ vagrant suspend
    $ vagrant destroy
    $ vagrant box remove FreeBSD-12.0-CURRENT-zfs-20170602-r319481-virtualbox

``FreeBSD-12.0-CURRENT-amd64-20170526-r318945``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Supported builders:

- ``vmware_fusion``::

    $ cd 12/ # This directory
    $ make 12.0-20170526-zfs PROVIDER=vmware-iso # EXTRA_OPTS="-var headless=false -debug"
    $ vagrant box add --name FreeBSD-12.0-CURRENT-zfs-20170526-r318945-vmware --provider=vmware_desktop FreeBSD-12.0-CURRENT-zfs-20170526-r318945-vmware.box
    $ cd ~/src/FreeBSD/my-work-dir # Must be in a different directory to run `vagrant init`
    $ vagrant init -m FreeBSD-12.0-CURRENT-zfs-20170526-r318945-vmware
    $ vagrant init --output Vagrantfile.example FreeBSD-12.0-CURRENT-zfs-20170526-r318945-vmware
    $ vagrant up --provider=vmware_fusion --destroy-on-error
    $ vagrant ssh
    $ vagrant suspend
    $ vagrant destroy
    $ vagrant box remove FreeBSD-12.0-CURRENT-zfs-20170526-r318945-vmware

- ``virtualbox``::

    $ cd 12/ # This directory
    $ make 12.0-20170526-zfs PROVIDER=virtualbox-iso EXTRA_OPTS="-var headless=false -debug"
    $ vagrant box add --name FreeBSD-12.0-CURRENT-zfs-20170526-r318945-virtualbox --provider=virtualbox FreeBSD-12.0-CURRENT-zfs-20170526-r318945-virtualbox.box
    $ cd ~/src/FreeBSD/my-work-dir # Must be in a different directory to run `vagrant init`
    $ vagrant init -m FreeBSD-12.0-CURRENT-zfs-20170526-r318945-virtualbox
    $ vagrant init --output Vagrantfile.example FreeBSD-12.0-CURRENT-zfs-20170526-r318945-virtualbox
    $ vagrant up --provider=virtualbox --destroy-on-error
    $ vagrant ssh
    $ vagrant suspend
    $ vagrant destroy
    $ vagrant box remove FreeBSD-12.0-CURRENT-zfs-20170526-r318945-virtualbox
