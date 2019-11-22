#!/usr/bin/env bash
function interpolate_options() {
  tmux show-option -gqv "$1" \
    | sed -e 's/#{ssid}/${SSID_CMD}/g' \
    | envsubst
}

export SSID_CMD="#($(dirname "$0")/bin/ssid)"

for option in status-left status-right; do
  tmux set-option -gq "${option}" "$(interpolate_options "${option}")"
done
