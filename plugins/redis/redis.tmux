#!/usr/bin/env bash
redis_running() {
  port=$(tmux show-environment REDIS_PORT 2> /dev/null | cut -d= -f2-)
  [[ -z "${port}" ]] && return 1
  lsof -i :${port} &> /dev/null
  return $?
}

function interpolate_options() {
  tmux show-option -gqv "$1" \
    | sed -e 's/#{redis_status}/${REDIS_STATUS}/g' \
    | envsubst
}

$(dirname $0)/bin/daemon &> /dev/null

if redis_running; then
  export REDIS_STATUS="r"
else
  export REDIS_STATUS="s"
fi

for option in status-left status-right; do
  tmux set-option -gq "${option}" "$(interpolate_options "${option}")"
done
