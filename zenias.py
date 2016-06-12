#!/usr/bin/python

# For argument parsing and --help
import argparse
# For some os-related path manipulations
import os
# For file manipulation (copy/move/...)
import shutil
#
# import sys
# To execute shell commands
from subprocess import call
# gitpython to manage Git repos.
# It's a wrapper for git system calls
from git import Repo
# pyyaml
import yaml

# Zenias function
from zenias_functions import (z_available_lang,
                              z_check_dir,
                              z_check_file,
                              z_check_language_config,
                              z_info,
                              z_logo,
                              z_make_templates,
                              z_merge_two_dicts,
                              z_success)
# Zenias variables
from zenias_vars import(Z_DEFAULT_YML, Z_VERSION)

# Zenias config
global Z_REPOS
user_file = os.path.expanduser('~/.zenias_custom.yml')

# Logo
z_logo()

# Load the official repos
with open('repos.yml', 'r') as f:
    off_config = yaml.load(f)
f.close()

# Load the user repos
z_check_file(user_file, Z_DEFAULT_YML)
with open(user_file, 'r') as f:
    user_config = yaml.load(f)
f.close()
# Deep merge the two dicts
Z_REPOS = z_merge_two_dicts(off_config, user_config)

#
# Parser for arguments
#
parser = argparse.ArgumentParser(prog='zenias')
# Main commands
subparsers = parser.add_subparsers()
#
# create the parser for the "create" command
parser_create = subparsers.add_parser('create',
                                      help='Creates a box. Use '
                                      '"zenias create -h" for help.')
# Language argument
parser_create.add_argument('language',
                           type=str,
                           help='The language/module you want to build '
                                'the box for. Use \'zenias list\' '
                                'for the complete list.')
# Directory argument
parser_create.add_argument('directory',
                           type=str,
                           default='.',
                           help='Directory where to create the box. '
                                'use "." to use the current directory.')
# Options argument
# parser_create.add_argument('-o', '--options',
#                            help='List of options. Please refer to the '
#                                 'specific options available for each boxes.')

#
# create the parser for the "list" command
parser_list = subparsers.add_parser('list',
                                    help='Display the list of all '
                                         'languages/modules.'
                                         'Use "zenias list -h" for help.')
# Language options
parser_list.add_argument('-l',
                         type=str,
                         default=None,
                         help='Restrict the list to this '
                              'language and submodules')
#
# create the parser for the "template" command
parser_template = subparsers.add_parser('template',
                                        help='Create an empty box structure. '
                                             'Use "zenias template -h"'
                                             'for help.')
# Language options
parser_template.add_argument('name',
                             type=str,
                             default=None,
                             help='Name for the new box')
# Directory argument
parser_template.add_argument('directory',
                             type=str,
                             default='.',
                             help='Directory where to create the skeleton. '
                                  'Use "." to use the current directory.')

args = parser.parse_args()

# List
# ------------------------
# List available languages (zenias list -l <lang>)
#
# as '-l' have a default and is tied to the "list" command,
# checking it's existence is enough to determine we want
# to list the boxes.
if 'l' in args:
    z_available_lang(args.l, Z_REPOS)
    exit(0)

# Template
# ------------------------
# Creates an empty box (zenias template <name> <directory>)
#
# as 'name' have a default and is tied to the "list" command,
# checking it's existence is enough to determine we want
# to list the boxes.
if('name' in args):
    target = os.path.abspath(args.directory)
    script = os.path.dirname(os.path.realpath(__file__))
    # Create the new dir
    z_check_dir(target)
    z_make_templates(os.path.join(script, 'skeleton'),
                     target,
                     dict(Z_VERSION=Z_VERSION, Z_LANG=args.name)
                     )
    z_success('Your new ' + args.name +
              'template is ready for customization in ' + target)
    exit(0)

# Create
# ------------------------
# Box creation

#
# Starting checks
#
print z_info('Attempting to create a box for ' +
             args.language + ' in "' + args.directory + '"...')
# Language presence and repo
repo = z_check_language_config(args.language, Z_REPOS)

if repo is None:
    exit(1)

print z_info('...The ' + args.language + ' box is available at ' + repo)


# Target dir, full path
target = os.path.abspath(args.directory)
# Source dir (zenias dir), full path
script = os.path.dirname(os.path.realpath(__file__))

#
# Checking target
#
z_check_dir(target)

# Getting repo
print z_info('...Cloning...')
Repo.clone_from(repo, target)
print z_success('...Done.')

# Removing the .git folder
print z_info('...Cleaning downloaded repo...')
shutil.rmtree(os.path.join(target, '.git'))
print z_success('...Done.')

# Copy zenias_bin for usage in guest
print z_info('...Copying some files...')
shutil.copyfile('./scripts/zenias_guest.sh',
                os.path.join(target, 'zenias_bin/', 'zenias')
                )

# Launch vagrant
print z_info('...Launching vagrant...')
os.chdir(target)
call(['vagrant', 'up'])

z_success("\nDone. Enjoy your box !\n")
