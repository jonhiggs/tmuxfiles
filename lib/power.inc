function battery_charge() {
  pmset -g batt |
    tail -n1 |
    awk '{ print $2 }' |
    tr -d [:punct:]
}

function power_source() {
  pmset -g batt |
    grep "Now drawing from" |
    grep -o \'.*\' |
    tr -d [:punct:] |
    awk '{ print $1 }'
}

# vim: ft=sh
