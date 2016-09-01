#!/usr/bin/env bats

load stub_helper

setup() {
  rm -rf "$XCENV_ROOT/shims"
  mkdir -p "$XCENV_ROOT/shims"
}

run_command() {
  run xcenv-rehash
  assert_success
}

@test "rehash should create shims" {
  run_command

  assert [ "$(ls -A "$XCENV_ROOT/shims")" ]
  assert [ -f "$XCENV_ROOT/shims/xcrun" ]
}

@test "rehash should not create xcode-select shim" {
  run_command

  assert [ ! -f "$XCENV_ROOT/shims/xcode-select" ]
}

@test "rehash should remove xcode-select shim" {
  touch "$XCENV_ROOT/shims/xcode-select"

  run_command

  assert [ ! -f "$XCENV_ROOT/shims/xcode-select" ]
}

@test "rehash should recreate shims" {
  run_command

  rm "$XCENV_ROOT/shims/xcrun"
  
  run_command
  
  assert [ -f "$XCENV_ROOT/shims/xcrun" ]
}