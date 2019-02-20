#!/usr/bin/env bash
BIN_DIR="$(dirname "$0")/bin"

function interpolate_options() {
  tmux show-option -gqv "$1" \
    | sed -e 's/#{aws_profile}/${PROFILE}/g' \
    | sed -e 's/#{aws_region}/${REGION}/g' \
    | envsubst
}

export PROFILE="#(${BIN_DIR}/profile)"
export REGION=":#(${BIN_DIR}/region)"

for option in status-left status-right; do
  tmux set-option -gq "${option}" "$(interpolate_options "${option}")"
done

