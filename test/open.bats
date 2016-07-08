#!/usr/bin/env bats

load stub_helper

setup() {
  mkdircd "$XCENV_TEST_TEMP"
}

run_command() {
  run xcenv-open $@
  echo $output
  assert_success
}

@test "open opens project passed in" {
  stub_executable_success "xcenv-version-name" "Xcode.app"

  expect_executable_parameter "open" 1 "-a"
  expect_executable_parameter "open" 2 "Xcode.app"
  expect_executable_parameter "open" 3 "test.xcworkspace"

  run_command test.xcworkspace
}

@test "open opens project xcworkspace path" {
  touch test.xcworkspace

  stub_executable_success "xcenv-version-name" "Xcode.app"

  expect_executable_parameter "open" 1 "-a"
  expect_executable_parameter "open" 2 "Xcode.app"
  expect_executable_parameter "open" 3 "test.xcworkspace"

  run_command
}

@test "open opens project xcodeproj" {
  touch test.xcodeproj

  stub_executable_success "xcenv-version-name" "Xcode.app"

  expect_executable_parameter "open" 1 "-a"
  expect_executable_parameter "open" 2 "Xcode.app"
  expect_executable_parameter "open" 3 "test.xcodeproj"

  run_command
}