#!/usr/bin/env bats

load stub_helper

setup() {
  mkdircd "$XCENV_TEST_TEMP"
}

run_command() {
  run xcenv-local $@
  assert_success
}

@test "local default" {
  run xcenv-local
  
  assert_failure "xcenv: no local version configured for this directory"
}

@test "unsetting local version" {
  touch "$XCENV_TEST_TEMP/.xcode-version"
  assert [ -f "$XCENV_TEST_TEMP/.xcode-version" ]
  
  run_command --unset
  
  assert [ ! -f "$XCENV_TEST_TEMP/.xcode-version" ]
}

@test "setting local version" {
  assert [ ! -f "$XCENV_TEST_TEMP/.xcode-version" ]
  
  expect_executable_parameter "xcenv-version-file-write" 1 "$XCENV_TEST_TEMP/.xcode-version"
  expect_executable_parameter "xcenv-version-file-write" 2 "1.2.3"
  
  run_command 1.2.3
}

@test "reading local version" {
  expect_executable_parameter "xcenv-version-file" 1 "$XCENV_TEST_TEMP"
  stub_executable_success "xcenv-version-file" ".xcode-version"

  expect_executable_parameter "xcenv-version-file-read" 1 ".xcode-version"
  stub_executable_success "xcenv-version-file-read" "1.2.3"
  
  run_command
  assert_output "1.2.3"
}