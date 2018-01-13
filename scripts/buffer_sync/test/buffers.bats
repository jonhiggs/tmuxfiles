#!/usr/bin/env bats
OPTIONS="-b buffer-test"
load ../lib/tmux-buffer-sync

@test "setting osx clipboard" {
  value=${RANDOM}
  _tbs_osx_clipboard "${value}"
  [ "$(_tbs_osx_clipboard)" = "${value}" ]
}

@test "setting tmux buffer" {
  value=${RANDOM}
  _tbs_tmux_buffer "${value}"
  [ "$(_tbs_tmux_buffer)" = "${value}" ]
}

@test "when clipboards are in sync" {
  osx=$(_tbs_osx_clipboard in_sync)
  tmux=$(_tbs_tmux_buffer in_sync)

  _tbs_sync
  [ "$(_tbs_osx_clipboard)" = "in_sync" ]
  [ "$(_tbs_tmux_buffer)" = "in_sync" ]
}

@test "set buffer from clipboard when buffer is unset" {
  _tbs_osx_clipboard "osx_clipboard"

  _tbs_sync

  [ "$(_tbs_tmux_buffer)" = "osx_clipboard" ]
  [ "$(_tbs_osx_clipboard)" = "osx_clipboard" ]
}

@test "set buffer from clipboard when buffer differs from clipboard" {
  _tbs_osx_clipboard "osx_clipboard"
  _tbs_tmux_buffer "tmux_buffer"

  _tbs_sync

  [ "$(_tbs_tmux_buffer)" = "osx_clipboard" ]
  [ "$(_tbs_osx_clipboard)" = "osx_clipboard" ]
}

teardown() {
  tmux delete-buffer -b ${TMUX_BUFFER_NAME} || true
}
