# -*- mode: ruby -*-
# vi: set ft=ruby :

# Setting nameserver for vms
$resolv = <<SCRIPT
echo 'Setting resolv.conf...'
echo 'nameserver 192.168.60.1' > /config/resolv.conf
SCRIPT

#Some APT tasks
$aptupdate = <<SCRIPT
echo 'Updating APT...'
sudo apt-get update
echo 'Installing packages...'
sudo apt-get install -y vim-nox
SCRIPT

Vagrant.configure(2) do |config|
  # https://docs.vagrantup.com.

  config.vm.define :master do |m|
    m.vm.box = "jessie-vbguest"
    m.vm.hostname = "SaltMaster"

    m.ssh.username = "vagrant"
    m.ssh.password = "vagrant"
    m.ssh.insert_key = "true"

    m.vm.network :private_network, ip: "192.168.60.10"
    # m.vm.network "forwarded_port", guest: 80, host: 8080

    # m.vm.provision :shell do |s|
    #   s.inline = $resolv
    #   s.inline = "sudo systemctl restart networking.service"
    #   s.inline = $aptupdate
    # end

    m.vm.synced_folder "./saltstack/salt", "/srv/salt"

    m.vm.provision :salt do |salt|
      salt.bootstrap_options = "-P -c /tmp"
      salt.master_config = "./saltstack/config/master.conf"
      salt.install_master = true
      salt.install_type = "stable"
      salt.no_minion = true
      salt.verbose = true
      salt.colorize = true
      salt.seed_master = {
        minion01: "./saltstack/keys/minion01.pub",
        minion02: "./saltstack/keys/minion02.pub"
      }
    end

    m.vm.provider :virtualbox do |vb|
       vb.gui = false
       vb.customize [ "modifyvm", :id,
         "--name", "SaltMaster",
         "--memory", "512",
         "--cpus", "1",
         "--vram", "16",
         "--cpuexecutioncap", "50",
       ]
    end
  end

  config.vm.define :minion01 do |m01|
    m01.vm.box = "jessie-vbguest"
    m01.vm.hostname = "SaltMinion01"

    m01.ssh.username = "vagrant"
    m01.ssh.password = "vagrant"
    m01.ssh.insert_key = "true"

    m01.vm.network :private_network, ip: "192.168.60.11"
    # m.vm.network "forwarded_port", guest: 80, host: 8080

    # m01.vm.provision "shell", inline: $resolv
    # m01.vm.provision "shell", inline: "sudo systemctl restart networking"

    m01.vm.provision :salt do |salt|
      salt.bootstrap_options = "-P -F -c /tmp"
      salt.minion_config = "./saltstack/config/minion01.conf"
      salt.minion_key = "./saltstack/keys/minion01.pem"
      salt.minion_pub = "./saltstack/keys/minion01.pub"
      salt.install_type = "stable"
      salt.colorize = true
      salt.verbose = true
    end

    m01.vm.provider :virtualbox do |vb|
       vb.gui = false
       vb.customize [ "modifyvm", :id,
         "--name", "SaltMinion01",
         "--memory", "256",
         "--cpus", "1",
         "--vram", "8",
         "--cpuexecutioncap", "50",
       ]
    end
  end

  config.vm.define :minion02 do |m02|
    m02.vm.box = "jessie-vbguest"
    m02.vm.hostname = "SaltMinion02"

    m02.ssh.username = "vagrant"
    m02.ssh.password = "vagrant"
    m02.ssh.insert_key = "true"

    m02.vm.network :private_network, ip: "192.168.60.12"
    # m.vm.network "forwarded_port", guest: 80, host: 8080

    # m02.vm.provision "shell", inline: $resolv
    # m02.vm.provision "shell", inline: "sudo systemctl restart networking"

    m02.vm.provision :salt do |salt|
      salt.bootstrap_options = "-P -F -c /tmp"
      salt.minion_config = "./saltstack/config/minion02.conf"
      salt.minion_key = "./saltstack/keys/minion02.pem"
      salt.minion_pub = "./saltstack/keys/minion02.pub"
      salt.install_type = "stable"
      salt.colorize = true
      salt.verbose = true
    end

    m02.vm.provider :virtualbox do |vb|
       vb.gui = false
       vb.customize [ "modifyvm", :id,
         "--name", "SaltMinion02",
         "--memory", "256",
         "--cpus", "1",
         "--vram", "8",
         "--cpuexecutioncap", "50",
       ]
    end
  end

  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end
end
