#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" Automates creating the development environment for Python, Django,
    and Vagrant on a local machine.
"""

import inspect
import os
import subprocess
import sys

from plumbum import local
from plumbum.cmd import mkdir, cp, git

script_path_inspect = inspect.getfile(inspect.currentframe())
# The absolute path to the source code directory.
source_path = os.path.dirname(os.path.abspath(script_path_inspect))
# The absolute path to the current working directory, where this script
# is being launched.
current_path = local.cwd
# Take in the first argument or option which is the project directory.
project_dir = sys.argv[1]
# Define absolute path to project directory.
project_path = current_path + "/" + project_dir
# Make a directory with the name project_dir.
mkdir(project_dir)
# Install .gitignore file.
cp(source_path + "/.gitignore", project_path)
# Install Vagrantfile.
cp(source_path + "/Vagrantfile", project_path)
# Install provisioning script.
cp(source_path + "/provision.sh", project_path)
# Install README.md
cp(source_path + "/readme.txt", project_path + "/README.md")
# Change current working directory to project directory.
local.cwd = project_path
# Initialise git local repository.
git("init")

# def main():
#     """ Peform copy commands in shell."""
#
#     script_path_inspect = inspect.getfile(inspect.currentframe())
#     script_path = os.path.dirname(os.path.abspath(script_path_inspect))
#     print 'What is the absolute path to your development directory?'
#     dev_dir_path = raw_input("> ")
#
#     # Install Vagrantfile
#     cmd_vagrant = 'cp %s/Vagrantfile %s' % (script_path, dev_dir_path)
#     subprocess.call(cmd_vagrant, shell=True)
#     # Install provision.sh
#     cmd_provision = 'cp %s/provision.sh %s' % (script_path, dev_dir_path)
#     subprocess.call(cmd_provision, shell=True)
#     # Install requirements.txt
#     cmd_requirements = 'cp %s/requirements.txt %s' % (script_path,
#                                                       dev_dir_path)
#     subprocess.call(cmd_requirements, shell=True)
#     # Install .gitignore
#     cmd_gitignore = 'cp %s/.gitignore %s' % (script_path, dev_dir_path)
#     subprocess.call(cmd_gitignore, shell=True)
#     # Install README.md
#     cmd_readme = 'cp %s/README.md %s' % (script_path, dev_dir_path)
#     subprocess.call(cmd_readme, shell=True)
#
# # Begin main() function if this script is called directly.
# if __name__ == '__main__':
#     main()
