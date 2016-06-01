# mingw Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/mingw.svg)][cookbook] [![Build Status](http://img.shields.io/travis/chef-cookbooks/mingw.svg?branch=master)][travis]

Installs a mingw/msys based compiler tools chain on windows. This is required for compiling C software from source.

## Requirements

### Platforms

- Windows

### Chef

- Chef 12+

### Cookbooks

- seven_zip
- compat_resource

## Usage

Add this cookbook as a dependency to your cookbook in its `metadata.rb` and include the default recipe in one of your recipes.

```ruby
# metadata.rb
depends 'mingw'
```

```ruby
# your recipe.rb
include_recipe 'mingw::default'
```

Use the `mingw_get` resource in any recipe to fetch mingw packages. Use the `mingw_tdm_gcc` resource to fetch a version of the TDM GCC compiler.

## Resources

### mingw_get

#### Actions

- `:install` - Installs a mingw package from sourceforge using mingw-get.exe.
- `:remove` - Uninstalls a mingw package.
- `:upgrade` - Upgrades a mingw package (even to a lower version).

#### Parameters

- `package` - A mingw-get package (or meta-package) to fetch and install. You may use a legal package wild-card pattern here if you are installing. This is the name attribute.
- `root` - The root directory where msys and mingw tools will be installed. This directory must not contain any spaces in order to pacify old posix tools and most Makefiles.

#### Examples

To get the core msys developer tools in `C:\mingw32`

```ruby
mingw_get 'msys-base=2013072300-msys-bin.meta' do
  root 'C:\mingw32'
end
```

### mingw_tdm_gcc

#### Actions

- `:install` - Installs the TDM compiler toolchain at the given path. This only gives you a compiler. If you need any support tooling such as make/grep/awk/bash etc., see `mingw_get`.

#### Parameters

- `flavor` - Either `:sjlj_32` or `:seh_sjlj_64`. TDM-64 is a 32/64-bit multi-lib "cross-compiler" toolchain that builds 64-bit by default. It uses structured exception handling (SEH) in 64-bit code and setjump-longjump exception handling (SJLJ) in 32-bit code. TDM-32 only builds 32-bit binaries and uses SJLJ.
- `root` - The root directory where compiler tools and runtime will be installed. This directory must not contain any spaces in order to pacify old posix tools and most Makefiles.
- `version` - The version of the compiler to fetch and install. This is the name attribute. Currently, '5.1.0' is supported.

#### Examples

To get the 32-bit TDM GCC compiler in `C:\mingw32`

```ruby
mingw_tdm_gcc '5.1.0' do
  flavor :sjlj_32
  root 'C:\mingw32'
end
```

## License & Authors

**Author:** Cookbook Engineering Team ([cookbooks@chef.io](mailto:cookbooks@chef.io))

**Copyright:** 2009-2016, Chef Software, Inc.

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

[cookbook]: https://supermarket.chef.io/cookbooks/mingw
[travis]: http://travis-ci.org/chef-cookbooks/mingw
