function memory_used() {
  memory_pressure | grep 'free percentage' | awk '{ print $5 }' | tr -d %
}

function memory_graph() {
  bargraph $(memory_used)
}

# vim: ft=sh
