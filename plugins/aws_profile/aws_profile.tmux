#!/usr/bin/env bash
BIN_DIR="$(dirname "$0")/bin"

function interpolate_options() {
  tmux show-option -gqv "$1" \
    | sed -e 's/#{yak_role}/${ROLE}/g' \
    | sed -e 's/#{yak_region}/${REGION}/g' \
    | envsubst
}

export ROLE="#(${BIN_DIR}/yak_role)"
export REGION="#(${BIN_DIR}/yak_region)"

for option in status-left status-right; do
  tmux set-option -gq "${option}" "$(interpolate_options "${option}")"
done

