#
# Cookbook Name:: heroku-toolbelt
# Attributes:: default
#
# Copyright (C) 2014 Patrick Ayoup
#
# MIT License
#

if platform_family?('debian')
  default[:heroku_toolkit][:install_command] = 'wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh'
else
  default[:heroku_toolkit][:install_command] = 'wget -qO- https://toolbelt.heroku.com/install.sh | sh'
end
