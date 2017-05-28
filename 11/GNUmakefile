EXTRA_OPTS ?=
TARGET ?= vmware-iso

.SUFFIXES: .json .json5

%.json: %.json5
	cfgt -i $< -o $@

default: help

20170510-zfs: amd64-20170510-zfs.json ## Build FreeBSD-11.0-STABLE-zfs-20170510-r318134
	$(MAKE) _build TARGET=$(TARGET) EXTRA_OPTS="$(EXTRA_OPTS)" TEMPLATE=$<

cfgt:: ## Install cfgt
	go get -u github.com/sean-/cfgt

patch-vagrant:: ## Patch Vagrant to prevent checking if NFS works or not
	sudo patch -p0 /opt/vagrant/embedded/gems/gems/vagrant-*/lib/vagrant/action/builtin/mixin_synced_folders.rb .vagrant-nfs.patch

install-nfs-mac:: ## Install the sudo command specs required for NFS shared folders on macOS
	@if [ -e /etc/sudoers.d/vagrant ]; then \
		echo "ERROR: /etc/sudoers.d/vagrant already exists"; \
		exit 1; \
	fi
	@sudo visudo --strict -c
	sudo sh -c 'install -m 0440 -o root -g wheel .sudo-vagrant-nfs /etc/sudoers.d/vagrant; visudo --strict -c || rm -f /etc/sudoers.d/vagrant;'
	@sudo visudo --strict -c

_build:
	@if [ -z "$(TARGET)" ]; then \
		printf "ERROR: specify a packer target. HINT: %s TARGET=<NAME>\n" "`basename $(MAKE)`"; \
		exit 1; \
	fi
	@if [ -z "$(TEMPLATE)" ]; then \
		printf "ERROR: specify a packer template. HINT: %s TEMPLATE=<NAME>\n" "`basename $(MAKE)`"; \
		exit 1; \
	fi
	packer build -only=$(TARGET) -var boot_wait=35s $(EXTRA_OPTS) $(TEMPLATE)

.PHONY: help
help:
	@echo "Valid targets:"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
