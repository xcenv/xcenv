#!/usr/bin/env bats

load stub_helper

run_command() {
  run xcenv-version-name $@
  assert_success
}

@test "version-name returns xcode-select path for system" {
  expect_executable_parameter "xcode-select" 1 "-p"
  stub_executable_success "xcode-select" "/some/path/to/Xcode.app"
  
  run_command system
  assert_output "/some/path/to/Xcode.app"
}

@test "version-name returns xcode-select path for system if no version-file-found" {
  stub_executable_success "xcenv-version-file" "system"
  stub_executable_failure "xcenv-version-file-read"

  expect_executable_parameter "xcode-select" 1 "-p"
  stub_executable_success "xcode-select" "/some/path/to/Xcode.app"
  
  run_command
  assert_output "/some/path/to/Xcode.app"
}

@test "version-name returns Xcode path for given version number" {
  stub_executable_success "xcenv-xcodes" "Xcode.app Xcode6.4.app Xcode7.2.app"
  
  CODE=`cat <<fi
    if [ "\\$1" = "Xcode.app" ]; then
      echo "8.0"
    elif [ "\\$1" = "Xcode6.4.app" ]; then
      echo "6.4"
    elif [ "\\$1" = "Xcode7.2.app" ]; then
      echo "7.2"
    fi
  `
  stub_executable "xcenv-xcode-version" "$CODE"
  
  run_command 6.4
  assert_output "Xcode6.4.app"
}