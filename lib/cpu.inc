function cpu() {
  top -l 2 -d | grep CPU\ usage | tail -n1 | awk '{ print $3, $5, $7 }' | tr -d %
}

function cpu_idle() {
  cpu | cut -d\  -f3
}

function cpu_used() {
  echo "100 - $(cpu_idle)" | bc
}


function cpu_graph() {
  bargraph $(printf "%.0f" $(cpu_used))
}

# vim: ft=sh
