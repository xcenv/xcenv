#!/usr/bin/env bats

load stub_helper

setup() {
  stub_list_of_xcodes
}

run_command() {
  run xcenv-versions
  assert_success
}

@test "versions prints list of versions for xcodes installed" {
  run_command
  assert_line 0 "8.0"
  assert_line 1 "6.3"
  assert_line 2 "6.4"
  assert_line 3 "7.2"
  assert_line 4 "8.0b"
}