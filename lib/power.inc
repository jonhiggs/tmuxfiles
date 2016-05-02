function battery_charge() {
  pmset -g batt |
    tail -n1 |
    awk '{ print $2 }' |
		sed 's/[^0-9]//g'
}

function battery_graph() {
  bargraph $(battery_charge)
}

# vim: ft=sh
