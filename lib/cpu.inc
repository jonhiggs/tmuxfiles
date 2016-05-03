function cpu_used() {
  samples_to_take=2
  top -l${samples_to_take} -d \
    | awk '
        /CPU\ usage/  {
                        gsub("%", "");
                        sum+=$3;
                        n++;
                      }
        END           { print 100 - (sum / n) }
      '
}

function cpu_graph() {
  bargraph $(printf "%.0f" $(cpu_used))
}

# vim: ft=sh
