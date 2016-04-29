# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    # Start with base vagrant box.
    config.vm.box = "ubuntu/trusty64"

    # Create forwarding ports for client-guest machine access via localhost.
    config.vm.network :forwarded_port, guest: 80, host: 8080
    config.vm.network :forwarded_port, guest: 8000, host: 8000

    # Provision the virtual machine.
    config.vm.provision :shell, :path => "provision.sh"
end
