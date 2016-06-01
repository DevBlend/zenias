name             'seven_zip'
maintainer       'Shawn Neal'
maintainer_email 'sneal@sneal.net'
license          'Apache 2.0'
description      'Installs/Configures the 7-zip file archiver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
ver_path = File.join(File.dirname(__FILE__), 'version.txt')
version File.exist?(ver_path) ? IO.read(ver_path).chomp : '2.0.0'
supports         'windows'

depends          'windows', '>= 1.2.2'
