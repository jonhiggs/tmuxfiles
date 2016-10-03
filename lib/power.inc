function battery_charge() {
  pmset -g batt               \
    | tail -n1                \
    | cut -d$'\t' -f2         \
    | awk -F\; '{ print $1 }' \
    | sed 's/[^0-9]//'
}

function battery_graph() {
  bargraph $(battery_charge)
}

# vim: ft=sh
