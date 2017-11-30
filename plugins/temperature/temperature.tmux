#!/usr/bin/env bash
function interpolate_options() {
  tmux show-option -gqv "$1" \
    | sed -e 's/#{air_temp}/${AIR_TEMP}/g' \
    | sed -e 's/#{rel_hum}/${REL_HUM}/g' \
    | envsubst
}

BIN_DIR="$(dirname "$0")/bin"
export AIR_TEMP="#(${BIN_DIR}/air_temp)"
export REL_HUM="#(${BIN_DIR}/rel_hum)"

for option in status-left status-right; do
  tmux set-option -gq "${option}" "$(interpolate_options "${option}")"
done
