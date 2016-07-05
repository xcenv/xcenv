load test_helper

XCENV_STUB_DIR="${XCENV_TEST_DIR}/stub"

PATH="${XCENV_STUB_DIR}:$PATH"
export PATH

stub_executable() {
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
  
  STUB_PATH=$(stub_executable $EXECUTABLE)
  echo "assert_equal \"$EXPECTED_VALUE\" \"\$$ARGUMENT_NUMBER\"" >> "$STUB_PATH"
}

stub_executable_failure() {
  EXECUTABLE=$1
  MESSAGE=$2
  
  if [ -n "$3" ]; then
    FAIL_CODE=$3
  else
    FAIL_CODE=1
  fi
  
  STUB_PATH=$(stub_executable $EXECUTABLE)
  echo "echo $MESSAGE 1>&2" >> "$STUB_PATH"
  echo "exit $FAIL_CODE" >> "$STUB_PATH"
}

stub_executable_success() {
  EXECUTABLE=$1
  MESSAGE=$2
  
  STUB_PATH=$(stub_executable $EXECUTABLE)
  echo "echo $MESSAGE" >> "$STUB_PATH"
  echo "exit 0" >> "$STUB_PATH"
}