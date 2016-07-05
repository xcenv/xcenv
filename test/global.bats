#!/usr/bin/env bats

load stub_helper

run_command() {
  run xcenv-global $@
  assert_success
}

@test "global default" {
  run_command
  assert_output "system"
}

@test "unsetting global version" {
  make_root_dir
  touch "$XCENV_ROOT/.xcode-version"
  assert [ -f "$XCENV_ROOT/.xcode-version" ]
  run_command --unset
  assert [ ! -f "$XCENV_ROOT/.xcode-version" ]
}

@test "setting global version" {
  make_root_dir
  assert [ ! -f "$XCENV_ROOT/.xcode-version" ]
  
  expect_executable_parameter "xcenv-version-file-write" 1 "$XCENV_ROOT/.xcode-version"
  expect_executable_parameter "xcenv-version-file-write" 2 "1.2.3"
  
  run_command 1.2.3
}

@test "reading global version" {
  make_root_dir
  assert [ ! -f "$XCENV_ROOT/.xcode-version" ]
  
  expect_executable_parameter "xcenv-version-file-read" 1 "$XCENV_ROOT/.xcode-version"
  stub_executable_success "xcenv-version-file-read" "1.2.3"
  
  run_command
  assert_output "1.2.3"
}