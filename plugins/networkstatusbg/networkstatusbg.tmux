#!/usr/bin/env bash
BIN_DIR="$(dirname "$0")/bin"

function interpolate_options() {
  tmux show-option -gqv "$1" \
    | sed -e 's/#{networkstatusbg}/${CMD}/g' \
    | envsubst
}

export CMD="#(${BIN_DIR}/status) "

for option in status-left status-right; do
  tmux set-option -gq "${option}" "$(interpolate_options "${option}")"
done

