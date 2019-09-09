#!/usr/bin/env bash
function interpolate_options() {
  tmux show-option -gqv "$1" \
    | sed -e 's/#{cpu}/${CPU_CMD}/g' \
    | sed -e 's/#{cpu_temp}/${CPU_TEMP_CMD}/g' \
    | sed -e 's/#{memory}/${MEMORY_CMD}/g' \
    | sed -e 's/#{battery}/${BATTERY_CMD}/g' \
    | sed -e 's/#{volume}/${VOLUME_CMD}/g' \
    | envsubst
}

BIN_DIR="$(dirname "$0")/bin"
export CPU_CMD="#(${BIN_DIR}/cpu)"
export CPU_TEMP_CMD="#(${BIN_DIR}/cpu_temp)"
export MEMORY_CMD="#(${BIN_DIR}/memory)"
export BATTERY_CMD="#(${BIN_DIR}/battery)"
export VOLUME_CMD="#(${BIN_DIR}/volume)"

for option in status-left status-right; do
  tmux set-option -gq "${option}" "$(interpolate_options "${option}")"
done
