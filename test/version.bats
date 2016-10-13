#!/usr/bin/env bats

load stub_helper

setup() {
  mkdircd "$XCENV_TEST_TEMP"
}

run_command() {
  run xcenv-version
  assert_success
}

@test "version prints version and origin" {
  stub_executable_success "xcenv-version-name" "/Applications/Xcode.app"
  stub_executable_success "xcenv-version-origin" "../.xcode-version"
  
  run_command
  assert_output "/Applications/Xcode.app (set by ../.xcode-version)"
}

@test "version handles environment variable" {
  export XCENV_VERSION=1.2.3
  stub_executable_success "xcenv-version-name" "/Applications/Xcode.app"
  
  run_command
  assert_output "/Applications/Xcode.app (set by XCENV_VERSION environment variable)"
  
  unset XCENV_VERSION
}