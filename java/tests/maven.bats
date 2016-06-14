#!/usr/bin/env bats

@test "maven version is 3 or higher" {
  version=$(mvn -version 2>&1|awk -F\" '/Apache Maven/ {print $1}' | grep -Po '(?<=Apache\sMaven\s)[^.]+')
  [ "$version" = "3" ]
}