function _memory_pressure() {
local used=$(
  memory_pressure             \
    | grep 'free percentage'  \
    | awk '{ print $5 }'      \
    | tr -d %
  )
  echo $(( 100 - ${used} ))
}

function memory_graph() {
  bargraph $(_memory_pressure)
}

# vim: ft=sh
