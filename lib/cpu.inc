function cpu() {
  if [[ -z ${CPU} ]]; then
    CPU=`top -l 2 -d | grep CPU\ usage | tail -n1 | awk '{ print $3, $5, $7 }' | tr -d %`
  fi

  echo $CPU
}

function cpu_user() {
  cpu | cut -d\  -f1
}

function cpu_sys() {
  cpu | cut -d\  -f2
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
