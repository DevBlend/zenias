#!/usr/bin/env bats

@test "tomcat is running" {
  run pgrep java
  [ $status -eq 0 ]
}

@test "java version is 1.8 or higher" {
  version=$(java -version 2>&1|awk -F\" '/version/ {print $2}')
  [ "$version" = "1.8.0_91" ]
}