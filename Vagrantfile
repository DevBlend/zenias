# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    # Start with base vagrant box. This one is only 271 MB in size.
    config.vm.box = "minimal/trusty64"

    # Create forwarding ports for client-guest machine access via localhost.
    config.vm.network :forwarded_port, guest: 80, host: 8080
    config.vm.network :forwarded_port, guest: 5000, host: 5000

    # Add the tty fix as mentioned in issue 1673 on vagrant repo
    # To avoid 'stdin is not a tty' messages
    # vagrant provisioning in shell runs bash -l
    config.vm.provision "fix-no-tty", type: "shell" do |s|
        s.privileged = false
        s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
    end

    # Provision the virtual machine.
    config.vm.provision :shell, :path => "provision.sh"
end
