#!/usr/bin/env bats

load stub_helper

run_command() {
  run xcenv-version-origin
  assert_success
}

@test "version-origin will return DEVELOPER_DIR value if defined" {
  export DEVELOPER_DIR="some/value"
  
  run_command
  
  assert_output "DEVELOPER_DIR environment variable"
}

@test "version-origin will return XCENV_VERSION value if defined" {
  export XCENV_VERSION="some/value"
  
  run_command
  
  assert_output "XCENV_VERSION environment variable"
}

@test "version-origin will return results of version-file success" {
  stub_executable_success "xcenv-version-file" "some/path"
  
  run_command
  
  assert_output "some/path"
}

@test "version-origin will return results of version-file failure" {
  stub_executable_failure "xcenv-version-file" "some error message"
  
  run xcenv-version-origin
  
  assert_failure "some error message"
}