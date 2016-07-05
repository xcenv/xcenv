#!/usr/bin/env bats

load stub_helper

setup() {
  mkdir -p "$XCENV_TEST_TEMP"
  cd "$XCENV_TEST_TEMP"
}

run_command() {
  run xcenv-xcodes
  assert_success
}

@test "xcodes executes mdfind" {
  expect_executable_parameter "mdfind" 1 "kMDItemCFBundleIdentifier == 'com.apple.dt.Xcode'"
  stub_executable_success "mdfind" "/Applications/Xcode.app\n/Applications/Xcode6.4.app"

  run_command
  assert_output "/Applications/Xcode.app\n/Applications/Xcode6.4.app"
}