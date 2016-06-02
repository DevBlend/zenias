#!/usr/bin/env bats

# This test is from https://github.com/metno/cookbook-kvalobs

@test "postgres is running" {
  run pgrep postgres
  [ $status -eq 0 ]
}

@test "can connect with psql" {
  run sudo -u postgres psql -d postgres -c 'select true'
  [ $status -eq 0 ]
}

@test "postgres version is 9.3 or higher" {
  # Show server_version; truncate to major.minor version number
  version=$(sudo -u postgres psql -d postgres -c 'SHOW server_version' -t | egrep -o '[0-9]{1,}\.[0-9]{1,}')
  [ "$version" \> "9.2" ]
}
