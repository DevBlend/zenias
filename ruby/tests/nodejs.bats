#!/usr/bin/env bats

@test "nodejs should be in the path" {
  [ "$(command -v nodejs)" ]
}
