load test_helper

XCENV_STUB_DIR="${XCENV_TEST_DIR}/stub"

PATH="${XCENV_STUB_DIR}:$PATH"
export PATH

stub_path() {
  EXECUTABLE=$1
  mkdir -p "$XCENV_STUB_DIR"
  STUB_PATH="${XCENV_STUB_DIR}/${EXECUTABLE}"
  if [ ! -f "$STUB_PATH" ]; then
    cp "${BATS_TEST_DIRNAME}/.stub" "$STUB_PATH"
  fi
  echo $STUB_PATH
}

expect_executable_parameter() {
  EXECUTABLE=$1
  ARGUMENT_NUMBER=$2
  EXPECTED_VALUE=$3
  
  stub_executable $EXECUTABLE "assert_equal \"$EXPECTED_VALUE\" \"\$$ARGUMENT_NUMBER\""
}

stub_executable_failure() {
  EXECUTABLE="$1"
  MESSAGE="$2"
  
  if [ -n "$3" ]; then
    FAIL_CODE="$3"
  else
    FAIL_CODE=1
  fi
  
  if [ -n "$MESSAGE" ]; then
    stub_executable $EXECUTABLE "echo $MESSAGE >&2"
  fi
  
  stub_executable $EXECUTABLE "exit $FAIL_CODE"
}

stub_executable_success() {
  EXECUTABLE="$1"
  MESSAGE="$2"
  
  if [ -n "$MESSAGE" ]; then
    stub_executable $EXECUTABLE "echo $MESSAGE"
  fi
  
  stub_executable $EXECUTABLE "exit"
}

stub_executable() {
  EXECUTABLE="$1"
  CODE="$2"
  
  STUB_PATH=$(stub_path $EXECUTABLE)
  echo -n "$CODE" >> "$STUB_PATH"
  echo >> "$STUB_PATH"
}

stub_list_of_xcodes() {
  stub_executable "xcenv-xcodes" "echo Xcode.app
    echo Xcode6.3.app
    echo Xcode6.4.app
    echo Xcode7.2.app
    echo Xcode-beta.app
    echo Xcode11.app"
  
  CODE=`cat <<fi
    if [ "\\$1" = "Xcode.app" ]; then
      echo "8.0"
    elif [ "\\$1" = "Xcode6.4.app" ]; then
      echo "6.4"
    elif [ "\\$1" = "Xcode6.3.app" ]; then
      echo "6.3"
    elif [ "\\$1" = "Xcode7.2.app" ]; then
      echo "7.2"
    elif [ "\\$1" = "Xcode-beta.app" ]; then
      echo "8.0b"
    elif [ "\\$1" = "Xcode11.app" ]; then
      echo "11.0"
    else
      echo "Unknown app: \\$1"
    fi
  `
  stub_executable "xcenv-xcode-version" "$CODE"
}