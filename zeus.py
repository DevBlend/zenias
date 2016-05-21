#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" Automatic creation of a local development environment.

Installation of a local Python-Django-Vagrant Stack based dev env.
"""

import inspect
import os
import sys

from plumbum import local, FG, colors
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

with colors.orchid:
    print "========== Setting up your project directory =========="
mkdir(project_dir)

with colors.orchid:
    print "========== Installing .gitignore =========="
cp(source_path + "/.gitignore", project_path)

with colors.orchid:
    print "========== Installing Procfile and Runtime for Heroku =========="
cp(source_path + "/Procfile", project_path)
cp(source_path + "/runtime.txt", project_path)

with colors.orchid:
    print "========== Installing Vagrant environment =========="
cp(source_path + "/Vagrantfile", project_path)
# Install provisioning script.
cp(source_path + "/provision.sh", project_path)
# Installing requirements.txt
cp(source_path + "/requirements.txt", project_path)
cp(source_path + "/.bashrc", project_path)
cp(source_path + "/gitconfig.sh", project_path)

with colors.orchid:
    print "========== Setting up bare README.md =========="
cp(source_path + "/readme.txt", project_path + "/README.md")
# Change current working directory to project directory.
local.cwd = project_path

with colors.orchid:
    print "========== Initialising local git repository =========="
git("init")

with colors.orchid:
    print "========== Launching vagrant up =========="
vagrant["up"] & FG

with colors.orchid:
    print "========== Initialising vagrant ssh session =========="
vagrant["ssh"] & FG
