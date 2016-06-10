#!/bin/bash
#
# YAY - a bash Yamlesque parser
#
# YAML is a data configuration format consisting of hierarchial "collections"
# of named data items. Yay is a parser that understands a subset of YAML, or
# Yamlesque, that is indended as a way to provide basic configuration or other
# data to bash shell scripts.
#
# Yamlesque has a structured syntax that is a small subset of YAML. Valid
# Yamlesque is also valid YAML but the reverse isn't necessarily true due to
# Yamlesque only supporting a basic subset of the YAML syntax. The name *Yay*
# is a reminder that _**Yaml ain't Yamlesque!**_
#
# Valid Yamlesque will pass a YAML validity check: http://www.yamllint.com. The
# full YAML specification is at http://yaml.org. Yamlesque meets the following
# format specification:
#
#     <indent><key>:[<value>]
#
# Yay is inspired by http://stackoverflow.com/a/21189044
#                and https://gist.github.com/pkuczynski/8665367
#
#
# MIT License. See https://github.com/johnlane/random-toolbox
#
########################################################### JL 20150720i #####
#
# Yamlesque is written in a plain text file and such files contain one or more
# input lines that consist of identifiers that are separated by whitespace:
#
# *  an indent
# *  a key
# *  a colon (:)
# *  a value
#
# Lines beginning with the octothorpe character (`#` aka `hash`, `sharp` or
# `pound`) are ignored, as is any trailing part of a line beginning with it.

# In general, whitespace is ignored except when it is leading whitespace, in
# which case it is considered to be an indent. An indent is zero or more pairs
# of space characters (`TAB` isn't valid YAML), each representing one level of
# indentation. 
#
# Note that, unlike YAML, two spaces must be used for each level of indentation.
#
# If a line does not have a value then it defines a new collection of key/value
# pairs which follow in subsequent lines and have one more level of indent.
#
# If a value is given then the key defines a setting in the collection. If the
# value is wrapped in quotation marks then these are removed, otherwise the
# value is used as-is including whitespace.
#
# Yay provides a bash function that reads an appropriately formatted data file
# and produces associative array definitions containing the data read from the
# file.
#
# This `yay_parse` function reads a Yay file and returns `bash` commands that
# can be executed to define *associative* arrays containing the data defined
# in the file. It takes one or two arguments:
#
#    yay_parse <filename> [<dataset>]
#
# Where `<filename>` is the name of the file. If the given name doesn't exist
# then further searches are performed with the suffixes `.yay` and `.yml`
# appended . The first matching file is used.
#
# The `<dataset>` is a label that is used to prefix the arrays that get
# created to reduce the risk of collissions. If omitted then the filename,
# less its suffix, is used.
#
# There are various ways to apply Yay definitions to the current shell environment:
#
# * `eval $(yay_parse demo)`
# * `source <(yay_parse demo)`
# * `yay_parse demo | source /dev/stdin`
#
# However, the easiest approach is to use the `yay` helper which loads data
# from the given file and creates arrays in the current environment.
#
# $ yay demo
#
# Yay uses associative arrays which are a feature of Bash version 4. It will
# not work with other bash versions.
#
# Usage
#
# First, include the Yay source in a script and then load a file
#
#    #!/bin/bash
#    . /path/to/yay
#    yay demo
#
# This leaves at least one array that is named after the data set. It will
# have entries per top-level key/value pair. It will also have a special
# entry called `keys` that contains a space-delimited string of the names of
# all such keys. Another special entry called `children` lists the names of
# further arrays defining other data sets within it. Such arrays follow the
# same structure.
#
# Here is a recursive example that displays a data set:
#
#    # helper to get array value at key
#    value() { eval echo \${$1[$2]}; }
#
#    # print a data set
#    print_dataset() { 
#      for k in $(value $1 keys)
#      do  
#        echo "$2$k = $(value $1 $k)"
#      done
#
#      for c in $(value $1 children)
#      do  
#        echo -e "$2$c\n$2{"
#        print_dataset $c "  $2"
#        echo "$2}"
#      done
#    }
#
#    yay demo
#    print_dataset demo
#


yay_parse() {

   # find input file
   for f in "$1" "$1.yay" "$1.yml"
   do
     [[ -f "$f" ]] && input="$f" && break
   done
   [[ -z "$input" ]] && exit 1

   # use given dataset prefix or imply from file name
   [[ -n "$2" ]] && local prefix="$2" || {
     local prefix=$(basename "$input"); prefix=${prefix%.*}
   }

   echo "declare -g -A $prefix;"

   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -n -e "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
          -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p" "$input" |
   awk -F$fs '{
      indent       = length($1)/2;
      key          = $2;
      value        = $3;

      # No prefix or parent for the top level (indent zero)
      root_prefix  = "'$prefix'_";
      if (indent ==0 ) {
        prefix = "";          parent_key = "'$prefix'";
      } else {
        prefix = root_prefix; parent_key = keys[indent-1];
      }

      keys[indent] = key;

      # remove keys left behind if prior row was indented more than this row
      for (i in keys) {if (i > indent) {delete keys[i]}}

      if (length(value) > 0) {
         # value
         printf("%s%s[%s]=\"%s\";\n", prefix, parent_key , key, value);
         printf("%s%s[keys]+=\" %s\";\n", prefix, parent_key , key);
      } else {
         # collection
         printf("%s%s[children]+=\" %s%s\";\n", prefix, parent_key , root_prefix, key);
         printf("declare -g -A %s%s;\n", root_prefix, key);
         printf("%s%s[parent]=\"%s%s\";\n", root_prefix, key, prefix, parent_key);
      }
   }'
}

# helper to load yay data file
yay() { eval $(yay_parse "$@"); }