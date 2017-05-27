EXTRA_OPTS ?=
TARGET ?= vmware-iso

.SUFFIXES: .json .json5

%.json: %.json5
	cfgt -i $< -o $@

default: help

20170510-r318134-zfs: amd64-20170510-r318134-zfs.json ## Build FreeBSD-11.0-STABLE-zfs-20170510-r318134
	$(MAKE) build TARGET=$(TARGET) EXTRA_OPTS="$(EXTRA_OPTS)" TEMPLATE=$<

build:
	@if [ -z "$(TARGET)" ]; then \
		printf "ERROR: specify a packer target. HINT: %s TARGET=<NAME>\n" "`basename $(MAKE)`"; \
		exit 1; \
	fi
	@if [ -z "$(TEMPLATE)" ]; then \
		printf "ERROR: specify a packer template. HINT: %s TEMPLATE=<NAME>\n" "`basename $(MAKE)`"; \
		exit 1; \
	fi
	packer build -only=$(TARGET) -var boot_wait=35s $(EXTRA_OPTS) $(TEMPLATE)

cfgt:: ## Install cfgt(1)
	go get -u github.com/sean-/cfgt

.PHONY: help
help:
	@echo "Valid targets:"
@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

