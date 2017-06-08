FreeBSD Packer Templates
==========================

This repository contains a collection of tools and scripts to build |FreeBSD|_
images using |packer|_ for a variety of target providers.

Installation
------------

To use this set of |packer|_ templates, the following prerequisites is required:

1. |gmake|_
2. |go|_
3. Install a recent version of |Vagrant|_ (you're on your own for this one)
4. Install a recent version of |packer|_::

    make install-packer
5. Install a recent version of |cfgt|_::

    make install-cfgt
6. Install one or more providers:

   a. |vagrant|_
   b. |VMware Fusion|_ ``8.5.7`` or newer
   c. |VirtualBox|_

   .. important:: If you are using |VMware Fusion|_, |VMware Fusion|_ Pro is
      *required* in order to have headless booting of FreeBSD images.  With
      VMware Fusion Pro, a new setting will appear under ``Preferences`` ->
      ``Network`` -> Uncheck the ``Require authentication to enter promiscuous
      mode`` box.

      .. image:: doc/vmware-fusion.png

      The alternative is to add the following to your ``Vagrantfile``::

        Vagrant.configure("2") do |config|
          # ...
          config.vm.provider "vmware_fusion" do |v|
            v.gui = true
          end
          # ...
        end

7. Install the ``sudo`` command aliases to enable NFS synced folders.  On
   ``macOS``::

    make install-nfs-mac

8. Patch |vagrant|_::

    make patch-vagrant

9. Verify dependencies are correctly installed::

    make verify

Optional:

- |reST|_ doc tools.  Assumes |virtualenv|_ and |pip|_ have been installed and
  are available in ``PATH``::

    make install-rst2pdf

Usage
-----

- See the ``README.rst`` in one of the top-level directories for details
  (e.g. `11/README
  <https://github.com/brd/packer-freebsd/blob/master/11/README.rst>`__, `12/README
  <https://github.com/brd/packer-freebsd/blob/master/12/README.rst>`__)
- To see the latest snapshot from a given release, run ``show-latest.sh`` with
  the version number you want (and optionally the architecture as the 2nd
  argument, defaults to ``amd64``)::

    $ sh show-latest.sh 12.0
    arch: amd64
    checksum_url: https://download.FreeBSD.org/ftp/snapshots/ISO-IMAGES/12.0/CHECKSUM.SHA512-FreeBSD-12.0-CURRENT-amd64-20170526-r318945
    iso_checksum: 8c76c3b4b7daf75bbaa100b3062a336a3df3a44d53bdce3912394e7c3512a4b51209fa27e857cec35a868725ca27e4c5b176159ccfe81252f25679b9bc059d98
    iso_filename: FreeBSD-12.0-CURRENT-amd64-20170526-r318945-disc1.iso
    iso_url: https://download.FreeBSD.org/ftp/snapshots/ISO-IMAGES/12.0/FreeBSD-12.0-CURRENT-amd64-20170526-r318945-disc1.iso
    iso_version: 12.0
    $ sh show-latest.sh 11.1
    arch: amd64
    checksum_url: https://download.FreeBSD.org/ftp/snapshots/ISO-IMAGES/11.1/CHECKSUM.SHA512-FreeBSD-11.1-PRERELEASE-amd64-20170525-r318893
    iso_checksum: fa0467019f4b899f08b0567767597bb72c328cdeea131d1cd3d3cfc9971c1451c946a581a13fb37e19aadbd6dda925015c84e94578d585d252646da0ff3e715a
    iso_filename: FreeBSD-11.1-PRERELEASE-amd64-20170525-r318893-disc1.iso
    iso_url: https://download.FreeBSD.org/ftp/snapshots/ISO-IMAGES/11.1/FreeBSD-11.1-PRERELEASE-amd64-20170525-r318893-disc1.iso
    iso_version: 11.1
    $ sh show-latest.sh 11.0
    arch: amd64
    checksum_url: https://download.FreeBSD.org/ftp/snapshots/ISO-IMAGES/11.0/CHECKSUM.SHA512-FreeBSD-11.0-STABLE-amd64-20170510-r318134
    iso_checksum: 257d4fa23d4b0d6f3dbe5e1ffce2f834eecee92d2102911993346a663bd377037a10ca451bb4048eed67a4ed4fe3328b106eda647c5fb3a28414b6e306eb4a64
    iso_filename: FreeBSD-11.0-STABLE-amd64-20170510-r318134-disc1.iso
    iso_url: https://download.FreeBSD.org/ftp/snapshots/ISO-IMAGES/11.0/FreeBSD-11.0-STABLE-amd64-20170510-r318134-disc1.iso
    iso_version: 11.0

FreeBSD Notes
-------------

- The VM is set to have 1024MB of RAM and a 20GB drive
- `Vagrant NFS synced folders
  <https://docs.vagrantup.com/v2/synced-folders/nfs.html>`__ are enabled by
  default and exported to the guest as ``/local``.
- `EFI bootloader doesn't work <https://github.com/brd/packer-freebsd/issues/23>`__

Vagrant Notes
^^^^^^^^^^^^^

- Install ``sudo(8)`` command specs for NFS shared folders::

    make install-nfs-mac

- Vagrant NFS Shared Folders: There is a `bug in Vagrant that prevents NFS
  shared folders from working
  <https://github.com/mitchellh/vagrant/issues/8624>`__.  To apply a patch to
  work around this bug::

    make patch-vagrant

- Initialize Vagrant using::

    vagrant init --minimal <box name>

- Initialize Vagrant boxes using a specific ``provider`` and clean up if there's a failure::

    vagrant up --provider=vmware_fusion --destroy-on-error

- Start the Vagrant VM::

    vagrant up

- Connect to the VM::

    vagrant ssh

- Hack away

  .. TIP:: ``cd /local`` assuming NFS synced folders is working

- Suspend the Vagrant VM::

    vagrant suspend

- Destroy a suspended VM::

    vagrant destroy

- See all images::

    vagrant global-status

Packer Notes
------------

- |packer|_ config files are written using |JSON5|_ and translated to regular
  JSON using |cfgt|_.
- To change the provider used to build an image, pass
  `PROVIDER=<MY_PROVIDER_NAME>` Defaults to ``vmware-iso`` but ``virtualbox``,
  ``parallels``, ``triton``, and others may work for a given template.
- |packer|_ may fail because the ``bsdinstall`` menus have changed when building
  a ``-CURRENT`` or ``-STABLE`` image.  To identify and fix this, pass in a
  populated ``EXTRA_OPTS`` variable to |gmake|_::

    make 11.1-20170519-zfs TARGET=vmware-iso EXTRA_OPTS="-var headless=false -debug"

  (and submit a patch fixing the menu change).
- If |packer|_ fails to connect via SSH to the instance to do the post-install
  it is possible there are too many SSH keys loaded in your agent.  Prefix your
  |gmake|_ command with `env SSH_AUTH_SOCK=/dev/null ...` or look at the output
  from ``ssh-add -l`` to see if you have more than 3x keys loaded.
- `Joyent <https://www.joyent.com/>`__ maintains a `branch of Packer that
  supports native JSON5 <https://github.com/joyent/packer/tree/f-json5>`__
  (``f-json5``).  It periodically lags behind ``master`` but should be
  reasonably up to date.

Contributing
------------

Patches welcome!  Specifically, as new snapshots or releases are made, please
feel free to submit PRs.

- Issues: `<https://github.com/brd/packer-freebsd/issues>`__
- PRs: `<https://github.com/brd/packer-freebsd/pulls>`__

.. |cfgt| replace:: ``cfgt(1)``
.. _cfgt: https://github.com/sean-/cfgt
.. |FreeBSD| replace:: FreeBSD
.. _FreeBSD: https://www.FreeBSD.org/
.. |gmake| replace:: GNU ``make(1)``
.. _gmake: https://www.gnu.org/software/make/
.. |go| replace:: Go
.. _go: https://www.golang.org/
.. |JSON5| replace:: JSON5
.. _JSON5: http://www.json5.org/
.. |packer| replace:: ``Packer``
.. _packer: https://www.packer.io/
.. |pip| replace:: ``pip(1)``
.. _pip: https://pypi.python.org/pypi/pip
.. |reST| replace:: ``reST``
.. _reST: http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html
.. |vagrant| replace:: ``Vagrant``
.. _vagrant: https://www.vagrantup.com/
.. |VirtualBox| replace:: VirtualBox
.. _VirtualBox: https://www.virtualbox.org/
.. |virtualenv| replace:: ``virtualenv(1)``
.. _virtualenv: https://pypi.python.org/pypi/virtualenv
.. |VMware Fusion| replace:: VMware Fusion
.. _VMware Fusion: https://www.vmware.com/products/fusion.html
