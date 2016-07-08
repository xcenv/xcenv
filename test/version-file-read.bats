#!/usr/bin/env bats

load stub_helper

setup() {
  mkdircd "$XCENV_TEST_TEMP"
}

run_command() {
  run xcenv-version-file-read $@
  assert_success
}

@test "version-file-read reads version file" {
  echo "1.2.3" > .xcode-version

  run_command .xcode-version
  assert_output "1.2.3"
}

@test "version-file-read fails if file doesn't exists" {
  run xcenv-version-file-read .xcode-version
  assert_failure ""
}

@test "version-file-read fails if file doesn't contain version" {
  touch .xcode-version

  run xcenv-version-file-read .xcode-version
  assert_failure ""
}
