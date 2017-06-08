GMAKE=`which 2> /dev/null gmake make | grep -v ^no | head -n 1`
GO?=go
MAJOR_VERSIONS=12 11
CFGT?=`go env GOPATH`/bin/cfgt
PACKER?=`go env GOPATH`/bin/packer
RST2PDF ?= rst2pdf

default: help

doc-check:: ## Checks docs for syntax errors
	@find . -name '*.rst' -type f ! -path '*lib*' -print0 | xargs -0 -n1 rstcheck
	@echo "OK: docs pass"

doc-pdf:: ## Checks docs for syntax errors
	rst2pdf README.rst

images:: ## Display the list of available images
	@for ver in `echo $(MAJOR_VERSIONS) | xargs -n1 echo | sort -rn`; do \
		$(GMAKE) -C $${ver}/ images | sort -r ; \
	done

install-packer:: ## Install a recent version of packer
	${GO} get -d -u github.com/hashicorp/packer
	@cd ${GOPATH}/src/github.com/hashicorp/packer/ ; \
		mv Makefile GNUmakefile                ; \
		${GMAKE} dev                           ; \
		mv GNUmakefile Makefile

install-cfgt:: ## Install cfgt
	${GO} get -u github.com/sean-/cfgt

install-nfs-mac:: ## Install the sudo command specs required for NFS shared folders on macOS
	@if [ -e /etc/sudoers.d/vagrant ]; then \
		echo "ERROR: /etc/sudoers.d/vagrant already exists"; \
		exit 1; \
	fi
	@sudo visudo --strict -c
	sudo sh -c 'install -m 0440 -o root -g wheel .sudo-vagrant-nfs /etc/sudoers.d/vagrant; visudo --strict -c || rm -f /etc/sudoers.d/vagrant;'
	@sudo visudo --strict -c

.SUFFIXES: .pdf .rst
%.pdf: %.rst
	$(RST2PDF) -o $@ $<

install-rst2pdf:: ## Install rst2pdf in a local virtualenv
	@virtualenv .                                  ; \
	source bin/activate || source bin/activate.csh ; \
	pip install rstcheck rst2pdf
	@echo 'Run: `source bin/activate || source bin/activate.csh` to activate the virtualenv'
	@echo 'Run: `deactivate` to escape the virtualenv'

clean:: ## Clean virtualenv
	rm -rf .Python bin/ include/ lib/

patch-vagrant:: ## Patch Vagrant to prevent checking if NFS works or not
	sudo patch -p0 /opt/vagrant/embedded/gems/gems/vagrant-*/lib/vagrant/action/builtin/mixin_synced_folders.rb .vagrant-nfs.patch

verify:: verify-gmake verify-go verify-cfgt verify-packer ## Run a series of verification checks to make sure all prereqs are present

verify-cfgt::
	@if [ ! -x "$(CFGT)" ]; then \
		echo "ERROR: Unable to find cfgt\n"; \
		exit 1; \
	fi
	@printf "OK: cfgt detected\n"

verify-gmake::
	@if [ -z "$(GMAKE)" ]; then \
		echo "ERROR: Unable to find GNU make in PATH\n"; \
		exit 1; \
	fi
	@if ! $(GMAKE) -v | grep -qs '^GNU Make'; then \
		echo "ERROR: Make is not GNU Make\n"; \
		exit 1; \
	fi
	@printf "OK: GNU Make detected\n"

verify-go::
	@if [ -z "$(GO)" ]; then \
		echo "ERROR: Unable to find Go in PATH\n"; \
		exit 1; \
	fi
	@if [ -z "`$(GO) version`" ]; then \
		echo "ERROR: Go is not valid\n"; \
		exit 1; \
	fi
	@if [ -z "`$(GO) env GOPATH`" ]; then \
		echo "ERROR: GOPATH is not set"; \
		exit 1; \
	fi
	@if [ ! -d "`$(GO) env GOPATH`/bin" ]; then \
		echo "ERROR: GOPATH is not a directory"; \
		exit 1; \
	fi
	@if [ ! -w "`$(GO) env GOPATH`/bin" ]; then \
		echo "ERROR: GOPATH is not writable"; \
		exit 1; \
	fi
	@if [ -z `echo $$PATH | tr ':' ' ' | xargs -n1 echo | grep "\`go env GOPATH\`/bin"` ]; then \
		echo "ERROR: GOPATH/bin is not in PATH"; \
		exit 1; \
	fi
	@printf "OK: Good to Go\n"

verify-packer::
	@if [ ! -x "$(PACKER)" ]; then \
		echo "ERROR: Unable to find packer\n"; \
		exit 1; \
	fi
	@printf "OK: packer detected\n"

.PHONY: help
help:
	@echo "Image Build Targets:"
	@$(GMAKE) images
	@echo
	@echo "Misc targets:"
	@grep -E '^[a-zA-Z_.-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
