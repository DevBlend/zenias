#
# Cookbook Name:: heroku-toolbelt
# Recipe:: default
#
# Copyright (C) 2014 Patrick Ayoup
#
# MIT License
#

# ensure wget is installed
package 'wget' do
  action :install
end

execute 'install toolbelt' do
  command node[:heroku_toolkit][:install_command]
end

# standalone is missing some dependencies.
if !platform_family?('debian')
  package 'git' do
    action :install
  end
  
  package 'ruby' do
    action :install
  end

  gem_package 'foreman'

  link "/bin/heroku" do
    to "/usr/local/heroku/bin/heroku"
  end
end