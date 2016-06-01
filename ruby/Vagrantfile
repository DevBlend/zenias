# encoding: utf-8

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "minimal/trusty64"
  config.ssh.forward_agent = true

  # Configue the virtual machines resources if you want
  config.vm.provider :virtualbox do |vb|
  # vb.cpus = 4 # 4 cpus
    vb.memory = 768 # minimum memory requirement
  end

  config.vm.network :forwarded_port, guest: 3000, host: 3000

  # Add the tty fix as mentioned in issue 1673 on vagrant repo
  # To avoid 'stdin is not a tty' messages
  # vagrant provisioning in shell runs bash -l
  config.vm.provision "fix-no-tty", type: "shell" do |s|
      s.privileged = false
      s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  # Use Chef Solo to provision our virtual machine
  config.vm.provision :chef_solo do |chef|
    #specify chef version to workaround bug
    chef.version = "12.10.40"
    chef.cookbooks_path = ["cookbooks"]

    chef.add_recipe "apt"
    #chef.add_recipe "build-essential::default"
    chef.add_recipe 'nodejs'
    chef.add_recipe "ruby_build"
    chef.add_recipe "ruby_rbenv::user"
    chef.add_recipe 'postgresql::server'
    chef.add_recipe 'heroku-toolbelt'

    # Install Ruby 2.3.1 and Gems
    chef.json = {
      rbenv: {
        user_installs: [{
          user:    'vagrant',
          rubies:  ["2.3.1"],
          global:  "2.3.1",
          gems:    {
                     "2.3.1" => [
                       { name: "bundler", version: "~>1.12.4" },
                       { name: "rspec",   version: "~>3.4.0"  },
                       { name: "rails",   version: "~>4.2.6"  },
                     ]
		   }
        }]
      },
      :postgresql => {
        :config   => {
          :listen_addresses => "*",
          :port             => "5432"
        },
        :pg_hba   => [
          {
            :type   => "local",
            :db     => "postgres",
            :user   => "postgres",
            :addr   => nil,
            :method => "trust"
          },
          {
            :type   => "host",
            :db     => "all",
            :user   => "all",
            :addr   => "0.0.0.0/0",
            :method => "md5"
          },
          {
            :type   => "host",
            :db     => "all",
            :user   => "all",
            :addr   => "::1/0",
            :method => "md5"
          }
        ],
        :password => {
          :postgres => "password"
        }
      },
    }
  end
end
