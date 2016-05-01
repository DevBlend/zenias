#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" Automatic creation of a development environment.

Python-Django-Vagrant Stack.
"""

import inspect
import os
import subprocess
import sys

from plumbum import local
from plumbum.cmd import mkdir, cp, git, vagrant

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
