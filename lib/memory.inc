function memory_used() {
  memory_pressure | grep 'free percentage' | awk '{ print $5 }' | tr -d %
}

# vim: ft=sh
