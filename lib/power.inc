function battery_charge() {
  pmset -g batt |
    tail -n1 |
    awk '{ print $2 }' |
		sed 's/[^0-9]//g'
}

function battery_state() {
  local state=$(
    pmset -g batt |
      tail -n1 |
      awk '{ print $3 }' |
      tr -d [:punct:]
  )

  case ${state} in
    "charged")     return 1 ;;
    "discharging") return 2 ;;
  esac
}

function power_source() {
  if [[ -z ${POWER_SOURCE} ]]; then
    POWER_SOURCE=$(
      pmset -g batt |
        grep "Now drawing from" |
        grep -o \'.*\' |
        tr -d [:punct:] |
        awk '{ print $1 }'
    )
  fi
  echo ${POWER_SOURCE}
}

function battery_symbol() {
  battery_state
  case $? in
    1) echo ${BATTERY_FULL}         ;;
    2) echo ${BATTERY_CHARGING}     ;;
    3) echo ${BATTERY_DISCHARGING}  ;;
    4) echo ${BATTERY_LOW}          ;;
  esac
}

function battery_graph() {
  bargraph $(battery_charge)
}

# vim: ft=sh
