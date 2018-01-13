#!/usr/bin/env bash
_tbs_osx_clipboard() {
  [[ $# -ne 0 ]] && echo "$@" | pbcopy
  pbpaste
}

_tbs_tmux_buffer() {
  [[ $# -ne 0 ]] && tmux set-buffer ${OPTIONS} "$@"
  tmux show-buffer ${OPTIONS} 2> /dev/null || true
}

_tbs_sync() {
  tmux set-buffer ${OPTIONS} "$(pbpaste)"
  return 0
}
