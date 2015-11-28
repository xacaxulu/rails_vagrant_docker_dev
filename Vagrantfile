# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "phusion/ubuntu-14.04-amd64"
  config.vm.synced_folder ".", "/vagrant", type: 'nfs'
  config.vm.network "forwarded_port", guest: 3000, host: 1234
  config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "6000"
  end

  

  #custom shell scripts
  config.vm.provision "shell", inline: <<-SHELL
  SHELL

  config.vm.provision "chef_apply" do |chef|
    chef.recipe = <<-RECIPE

      bash 'sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D'

      file "/etc/apt/sources.list.d/docker.list" do
        content 'deb https://apt.dockerproject.org/repo ubuntu-trusty main'
        notifies :run, "bash[update_apt]", :immediately
      end

      bash 'update_apt' do
        code 'apt-get update'
        action :nothing
      end


      bash "apt-get install -y linux-image-extra-$(uname -r)"

      bash "apt-get install -y docker-engine --fix-missing --force-yes"

      group 'docker' do

      end

      bash 'docker_sudoer' do
        code 'sudo usermod -aG docker vagrant'
      end

      service 'docker' do
        action :start
      end
    RECIPE
  end
end
