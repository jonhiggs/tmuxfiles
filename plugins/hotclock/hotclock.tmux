#!/usr/bin/env bash
function interpolate_options() {
  tmux show-option -gqv "$1" \
    | sed -e 's/#{hotclock}/${HOTCLOCK_CMD}/g' \
    | envsubst
}

export HOTCLOCK_CMD='    #(date +%Y-%m-%d)#{?client_prefix, #[bg=red]#[fg=white] #(date "+%H:%M") #[bg=colour234] ,  #(date "+%H:%M")  }'

for option in status-left status-right; do
  tmux set-option -gq "${option}" "$(interpolate_options "${option}")"
done

