if [[ ! -o interactive ]]; then
    return
fi

compctl -K _xcenv xcenv

_xcenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(xcenv commands)"
  else
    completions="$(xcenv completions ${words[2,-2]})"
  fi

  reply=("${(ps:\n:)completions}")
}