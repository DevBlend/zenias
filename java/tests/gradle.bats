#!/usr/bin/env bats

@test "gradle version is 2 or higher" {
  version=$( gradle -version 2>&1|awk -F\" '/Gradle/ {print $1}' | grep -Po '(?<=Gradle\s)[^.]+')
  [ "$version" = "2" ]
}