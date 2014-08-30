function battery_charge() {
  if [[ -z ${BATTERY_CHARGE} ]]; then
    BATTERY_CHARGE=$(
      pmset -g batt |
        tail -n1 |
        awk '{ print $2 }' |
        tr -d [:punct:]
    )
  fi

  echo ${BATTERY_CHARGE}
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

function battery_state() {
  case $(power_source) in
    "AC")
      if [[ $(battery_charge) -ge 100 ]]; then
        return 1
      else
        return 2
      fi
    ;;

    "Battery")
      if [[ $(battery_charge) -gt 15 ]]; then
        return 3
      else
        return 4
      fi
    ;;
  esac
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

# vim: ft=sh
