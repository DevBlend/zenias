#!/usr/bin/python

# used to read files
import io
# For some os-related path manipulations
import os
# import sys
# Mini template engine
from string import Template
# Zenias version
from zenias_vars import Z_VERSION


# Displays a nice logo
def z_logo():
    description = (OutColors.ENDC +
                   'Zenias: Vagrant boxes with Heroku integration')
    version = OutColors.ENDC + 'V ' + Z_VERSION
    print OutColors.BLUE
    print ' _______ _ __ (_) __ _ ___  '
    print '|_  / _ \ `_ \| |/ _` / __| ' + description + OutColors.BLUE
    print ' / /  __/ | | | | (_| \__ \ '
    print '/___\___|_| |_|_|\__,_|___/ ' + version
    print
    print


# Nice messages
def z_error(msg):
    return ("\n" + OutColors.LRED + 'Error: ' +
            OutColors.RED + msg + OutColors.ENDC + "\n")


def z_warning(msg):
    return ("\n" + OutColors.LYELLOW + 'Error: ' +
            OutColors.YELLOW + msg + OutColors.ENDC + "\n")


def z_info(msg):
    return (OutColors.LBLUE + 'Info: ' +
            OutColors.BLUE + msg + OutColors.ENDC)


def z_success(msg):
    return (OutColors.LGREEN + 'Error: ' +
            OutColors.GREEN + msg + OutColors.ENDC)


def z_underline(msg):
    return OutColors.UNDERLINE + msg + OutColors.ENDC


# Displays a header... Not used, but nice :)
# I created those to stick to the current old "zeus" style of outputs,
# so we have to take a decision 'bout this.
def z_header1(msg):
    linelenght = 80
    line = '+' + (linelenght - 2) * '-' + '+'
    blank = '\n|' + (linelenght - 2) * ' ' + '|\n'
    return (line + blank +
            "| " + msg + " " + (linelenght - 4 - len(msg)) * ' ' + "|" +
            blank + line)


# Smaller header. Nice too.
# Same notes as z_header1
def z_header2(msg):
    linelenght = 80
    line = '+' + (linelenght - 2) * '-' + '+'
    return (line +
            "\n| " + msg + " " + (linelenght - 4 - len(msg)) * ' ' + "|\n" +
            line)


# Defining some colors for console output candyness
class OutColors:
    BLUE = '\033[34m'
    LBLUE = '\033[94m'
    GREEN = '\033[32m'
    LGREEN = '\033[92m'
    RED = '\033[31m'
    LRED = '\033[91m'
    YELLOW = '\033[33m'
    LYELLOW = '\033[93m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    ENDC = '\033[0m'


# Returns the language for a submodule
def z_get_parent_lang(module, config):
    for l in config:
        if ('modules' in config[l]) and (config[l]['modules'] is not None):
            for m in config[l]['modules']:
                if module == m:
                    return l
    return None


# Displays the list of all the available lang/modules
def z_available_lang(lang, config):
    if(lang is None):
        # Generate a langauge/modules list:
        print z_underline('Available langages:')
        for l in config:
            name = OutColors.BLUE + ' - ' + l + OutColors.ENDC
            if 'description' in config[l]:
                name += ' - ' + config[l]['description']
            print name
            if ('modules' in config[l]) and (config[l]['modules'] is not None):
                for m in config[l]['modules']:
                    name = OutColors.LBLUE + '  - ' + m + OutColors.ENDC
                    if 'description' in config[l]['modules'][m]:
                        name += ' - ' + config[l]['modules'][m]['description']
                    print name
                print
    elif lang in config:
        l = lang
        print z_underline('Language and modules for ' + l + ':')
        name = OutColors.BLUE + ' - ' + l + OutColors.ENDC
        if 'description' in config[l]:
            name += ' - ' + config[l]['description']
        print name
        if ('modules' in config[l]) and (config[l]['modules'] is not None):
            for m in config[l]['modules']:
                name = OutColors.LBLUE + '  - ' + m + OutColors.ENDC
                if 'description' in config[l]['modules'][m]:
                    name += ' - ' + config[l]['modules'][m]['description']
                print name
        print
    else:
        z_error('Sorry, we don\'t have this language...')
        exit(1)


# Checks if a given language/module exists in config, and if it's valid.
# For nicer implementations, we should remove the exit() from there and return
# true/false
def z_check_language_config(lang, config):
    repo = None
    if(lang not in config):
        # Check in modules
        l = z_get_parent_lang(lang, config)
        if(l is None):
            print z_error('Unable to find ' + lang +
                          ' in languages and modules.')
            exit(1)
        else:
            # Check repo presence
            if config[l]['modules'][lang]['main'] is None:
                print z_error('This module is misconfigured.')
                exit(1)
            else:
                repo = config[l]['modules'][lang]['main']
    elif config[lang]['main'] is None:
        print z_error('This language is misconfigured.')
        exit(1)
    else:
        repo = config[lang]['main']
    return repo


# Checks if directory exists and not empty
# For nicer implementations, we should remove the exit() from there and return
# true/false
def z_check_dir(directory):
    if not os.path.exists(directory):
        print z_info('Creating ' + directory)
        os.makedirs(directory)
    # Existant and non empty
    elif os.listdir(directory) != []:
        print z_error('The "' + directory + '" directory is not empty.')
        exit(1)
    # Existant and empty
    else:
        print z_info('...Directory ' + directory + ' exists and is empty')


# walk trough a source dir, create its dirs recursively in in target dir.
# All the files are processed through a simple templating system
# That explain why the skeleton's files have bad definitions in it.
def z_make_templates(source, target, replacements):
    for f in os.listdir(source):
        newtarget = os.path.join(target, f)
        newsource = os.path.join(source, f)
        if os.path.isdir(newsource):
            os.makedirs(newtarget)
            print z_info('Created folder ' + f)
            z_make_templates(newsource, newtarget, replacements)
        else:
            targetfile = io.open(newtarget, 'w')
            sourcefile = io.open(newsource, 'r')
            for line in sourcefile:
                template = Template(line)
                targetfile.write(template.substitute(replacements))
            targetfile.close()
            print z_info('Created file ' + f)


# Merge two dicts recursively.
# Values from y will override the ones from x
# Returns x or y if the other is empty.
def z_merge_two_dicts(x, y):
    if x is None and y is not None:
        return y
    elif x is not None and y is None:
        return x
    elif x is None and y is None:
        return dict()
    else:
        if type(y) is dict:
            for i in y:
                if i not in x:
                    x[i] = None
                x[i] = z_merge_two_dicts(x[i], y[i])

        else:
            x = y
        return x


# Check for a file file and create it with some content if necessary
def z_check_file(a_file, content):
    if not os.path.isfile(a_file):
        print z_info('Creating a file for your unofficial boxes in ' +
                     a_file)
        content = str(content)
        the_file = open(a_file, 'a')
        the_file.write(str(content))
        the_file.close()
