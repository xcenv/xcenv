#!/usr/bin/env bats

load stub_helper

setup() {
  rm -rf "$XCENV_ROOT/shims"
  mkdir -p "$XCENV_ROOT/shims"
  
  mkdir -p "$USR_BIN"
  touch "$USR_BIN/notshimmed"
  touch "$USR_BIN/xcrun"
  touch "$USR_BIN/git"
  touch "$USR_BIN/lex"
  touch "$USR_BIN/flex"
  touch "$USR_BIN/xcode-select"
  
  export XCENV_DO_NOT_SHIM_LIST=""
}

run_command() {
  run xcenv-rehash
  assert_success
}

assert_shim_file_exists() {
  assert [ -f "$XCENV_ROOT/shims/$1" ]
}

assert_shim_file_does_not_exist() {
  assert [ ! -f "$XCENV_ROOT/shims/$1" ]
}

@test "rehash should create shims" {
  run_command

  assert [ "$(ls -A "$XCENV_ROOT/shims")" ]
  assert_shim_file_exists "xcrun"
  assert_shim_file_does_not_exist "notshimmed"
}

@test "rehash should not create xcode-select shim" {
  run_command

  assert_shim_file_does_not_exist "xcode-select"
}

@test "rehash should remove xcode-select shim" {
  touch "$XCENV_ROOT/shims/xcode-select"

  run_command

  assert_shim_file_does_not_exist "xcode-select"
}

@test "rehash should recreate shims" {
  run_command

  rm "$XCENV_ROOT/shims/xcrun"
  
  run_command
  
  assert_shim_file_exists "xcrun"
}

@test "rehash will ignore shims in XCENV_DO_NOT_SHIM_LIST" {
  export XCENV_DO_NOT_SHIM_LIST="xcrun git"
  
  run_command
  
  assert_shim_file_does_not_exist "xcrun"
  assert_shim_file_does_not_exist "git"
  assert_shim_file_exists "lex"
}

@test "rehash will ignore shims that match whole name" {
  export XCENV_DO_NOT_SHIM_LIST="flex"
  
  run_command
  
  assert_shim_file_does_not_exist "flex"
  assert_shim_file_exists "lex"
}