#!/usr/bin/env bash
function interpolate_options() {
  tmux show-option -gqv "$1" \
    | sed -e 's/#{weather_air_temp}/${AIR_TEMP}/g' \
    | sed -e 's/#{weather_rel_hum}/${REL_HUM}/g' \
    | sed -e 's/#{weather_data_time}/${DATA_TIME}/g' \
    | envsubst
}

BIN_DIR="$(dirname "$0")/bin"
export AIR_TEMP="#(${BIN_DIR}/air_temp)"
export REL_HUM="#(${BIN_DIR}/rel_hum)"
export DATA_TIME="#(${BIN_DIR}/data_time)"

for option in status-left status-right; do
  tmux set-option -gq "${option}" "$(interpolate_options "${option}")"
done
