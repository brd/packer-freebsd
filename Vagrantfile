# -*- mode: ruby; -*-

### BEGIN: Configuration

# Setup the Hardware
HW_NUM_CPUS=4
HW_MEM_MB=1024

# DEBUG_GUI toggles whether or not the console is activated by default.  Set
# to true for debugging purposes.  Default false.
DEBUG_GUI=false

# HOSTNAME_FMT sets the name of the box based on the flavor.  By default this
# is `FreeBSD-#{Flavor}%02d", or "FreeBSD-ports01"
HOSTNAME_FMT="FreeBSD-%s%02d"

# BOX_VARIANTS specifies the avaialble variants.  The variants `doc`,
# `ports`, and `src` are reserved variant names in that those variants are
# preconfigured for the FreeBSD doc project, ports, or src activities.
# Additional variants can be added and will include no special configuration.
BOX_VARIANTS=[":3", "doc:1","ports:1","src:1"]

# Rare settings
DEFAULT_VMS_PER_VARIANT=3

# Use RFC 6598's private IP range by default (100.64.0.0/10).
NETWORK="100.64.0.0/10"
### END: Configuration

###### NOTE: Don't edit anything below this line

def configureVM(config)
  config.ssh.forward_env = [
    "_FREEBSD_VAGRANT_DOCS=Y",
    "_FREEBSD_VAGRANT_PORTS=Y",
    "_FREEBSD_VAGRANT_SRC=Y",
  ]
  config.ssh.shell = "tcsh"
  config.ssh.sudo_command = 'sudo -E -H %c'

  config.vm.box = "FreeBSD-10.3-STABLE-zfs-20160518-r300092"
  config.vm.guest = :freebsd
  config.vm.provision :shell, privileged: false, path: "bootstrap-CURRENT.sh"
  # config.vm.network "private_network", ip: "1.0.0.2"
  # config.vm.network :forwarded_port, guest: 80, host: 4567
  config.vm.post_up_message = "Customized post-up message"
  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.vm.provider "parallels" do |p, override|
    override.vm.box = "parallels/FreeBSD-10.3-STABLE-zfs-20160518-r300092"
    p.cpus = HW_NUM_CPUS.to_s
    p.memory = HW_MEM_MB.to_s
  end

  config.vm.provider "virtualbox" do |vb|
    vb.gui = DEBUG_GUI
    vb.memory = HW_MEM_MB.to_s
    vm.cpus = HW_NUM_CPUS.to_s

    #vb.customize ["modifyvm", :id, "--memory", HW_MEM_MB.to_s]
    #vb.customize ["modifyvm", :id, "--cpus", HW_NUM_CPUS.to_s]
    vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
  end

  ["vmware_fusion", "vmware_workstation"].each do |p|
    config.vm.provider p do |vmw|
      vmw.gui = DEBUG_GUI
      vmw.memory = HW_MEM_MB.to_s
      vmw.cpus = HW_NUM_CPUS.to_s
      # vmw.vmx["memsize"] = HW_MEM_MB.to_s
      # vmw.vmx["numvcpus"] = HW_NUM_CPUS.to_s
      vmw.vmx["ide1:0.present"] = "FALSE"
    end
  end
end

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  BOX_VARIANTS.each do |boxVariant|
    md = /([^\:]*)(?:[:]([\d]+))/.match(v)
    next if md.nil?
    numVariants = (!md[2].nil? ? md[2].to_i : DEFAULT_VMS_PER_VARIANT)
    if numVariants == 1
      vmName = "FreeBSD-%s" % [md[1]]
    else
      vmName = "FreeBSD-%s%02d" % [md[1], numVariants]
  end

  1.upto(MAX_VMS_PER_FLAVOR) do |n|
    vmName = HOSTNAME_FMT % [n]
    autostart = (n == 1 ? true : false)
    primary = (n == 1 ? true : false)
    config.vm.define vmName, autostart: autostart, primary: primary do |vmCfg|
      vmCfg.vm.hostname = vmName
      vmCfg = configureVM(vmCfg)
    end
  end

  1.upto(MAX_VMS_PER_FLAVOR) do |n|
    vmName = HOSTNAME_FMT % [n]
    config.vm.define vmName, autostart: false, primary: false do |vmCfg|
      vmCfg.vm.hostname = vmName
      vmCfg = configureVM(vmCfg)
    end
  end
end
