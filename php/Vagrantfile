# -*- mode: ruby -*-
# vi: set ft=ruby :

#-------------------------------------------------------------------------------
# Vagrant configuration file, highly based on
#   https://github.com/tektoh/heroku-cakephp3-app
#   https://github.com/alayek/zeus
#   and some strings found on puphpet boxes (http://puphpet.com)
#
# Author: Manuel Tancoigne
# Original authors:
#   - Shinichi Segawa (https://github.com/tektoh/),
#   - Arijit Layek (https://github.com/alayek/)
#
# This box will create a minimal virtual box (ubuntu trusty-x64) with minimal
# packages required to run an apache2 webserver with php5 and postgreSQL.
#
# CakePHP is a slightly modified version of the official cakePHP 3.2, with minor
# changes to make Heroku deployment a piece of cake.
#
# All credit goes to Shinichi Segawa (tektoh) for his implementation, I only
# updated his work to CakePHP 3.2.
#-------------------------------------------------------------------------------
Vagrant.configure('2') do |config|
  # Box version
  config.vm.box = 'minimal/trusty64'

  # Host name
  config.vm.hostname = 'fcc-vagrant-php'

  # Network config
  # --------------
  # Host IP adress. Usefull as we have a server running here.
  config.vm.network :private_network, ip: '192.168.56.101'
  # Binding ports, so you can still access with localhost:<port>
  config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
  #config.vm.network :forwarded_port, guest: 22, host: 2222, auto_correct: true
  config.vm.network :forwarded_port, guest: 5432, host: 5434, auto_correct:true

  # VirtualBox config
  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '512']
  end

  # Shared folder.
  config.vm.synced_folder '.', '/vagrant',
                          owner: 'www-data',  # Setting owner and group to Apache
                          group: 'www-data',  # This will avoid permissions issues
                          mount_options: ['dmode=775', 'fmode=774'] # Default file mode

  # https://github.com/fgrehm/vagrant-cachier
  # This will reduce provision time with cached packages, shared between machines.
  if Vagrant.has_plugin?('vagrant-cachier')
    machine_id.cache.scope = :box
  end

  # Add the tty fix as mentioned in issue 1673 on vagrant repo
  # To avoid 'stdin is not a tty' messages
  # vagrant provisioning in shell runs bash -l
  config.vm.provision "fix-no-tty", type: "shell" do |s|
      s.privileged = false
      s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  # Provision script
  config.vm.provision :shell, path: './vagrant/provision.sh'
end
