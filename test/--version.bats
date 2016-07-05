#!/usr/bin/env bats

load test_helper

@test "version displayed" {
  assert [ ! -e "$XCENV_ROOT" ]
  run xcenv---version
  assert_success
  assert_output "xcenv "?.?.?
}