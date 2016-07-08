#!/usr/bin/env bats

load stub_helper

setup() {
  mkdircd "$XCENV_TEST_TEMP"
}

run_command() {
  run xcenv-version-file-write $@
  assert_success
}

@test "version-file-write writes version to desired file if xcode exists" {
  expect_executable_parameter "xcenv-version-name" 1 1.2.3
  stub_executable_success "xcenv-version-name"

  run_command .xcode-version 1.2.3
  
  [ -e .xcode-version ]
  [ $(cat .xcode-version) = "1.2.3" ]
}

@test "version-file-write invalid input prints usage" {
  USAGE="Usage: xcenv version-file-write <file> <version>"

  run xcenv-version-file-write
  assert_failure $USAGE
  
  run xcenv-version-file-write .xcode-version
  assert_failure $USAGE
}

@test "version-file-write fails if Xcode version does not exist" {
  stub_executable_failure "xcenv-version-name" "error message"

  run xcenv-version-file-write .xcode-version 1.2.3
  assert_failure "error message"
}