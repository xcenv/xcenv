#!/usr/bin/env bats

load stub_helper

setup() {
  mkdircd "$XCENV_TEST_TEMP"
}

run_command() {
  run xcenv-version-file $@
  assert_success
}

@test "version-file will return system if no files found" {
  run_command
  
  assert_output "system"
}

@test "version-file will return global file path if file exists" {
  make_global_file
  
  run_command
  
  assert_output "$XCENV_ROOT/.xcode-version"
}

@test "version-file will return file path in current directory if file exists" {
  touch ".xcode-version"
  
  run_command
  
  assert_output "$XCENV_TEST_TEMP/.xcode-version"
}

@test "version-file will return file path in parent directory if file exists" {
  touch ".xcode-version"
  mkdircd "some/childre/down/further"
  
  run_command
  
  assert_output "$XCENV_TEST_TEMP/.xcode-version"
}

@test "version-file will return path found from argument path" {
  touch ".xcode-version"
  
  run_command "$XCENV_TEST_TEMP"
  
  assert_output "$XCENV_TEST_TEMP/.xcode-version"
}

@test "version-file will return nothing if no file found in parent" {
  run xcenv-version-file "$XCENV_TEST_TEMP"
  
  assert_failure ""
}

@test "version-file will prefer XCENV_DIR over PWD" {
  touch ".xcode-version"
  mkdircd "some/child/down/further"
  touch ".xcode-version"
  
  XCENV_DIR=$XCENV_TEST_TEMP run_command
  
  assert_output "$XCENV_TEST_TEMP/.xcode-version"
}