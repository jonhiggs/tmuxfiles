function bargraph() {
  case $(( $1 / 10 )) in
    0|1)
      echo -n " "
      ;;
    2)
      echo -n "▁"
      ;;
    3)
      echo -n "▂"
      ;;
    4)
      echo -n "▃"
      ;;
    5)
      echo -n "▄"
      ;;
    6)
      echo -n "▅"
      ;;
    7)
      echo -n "▆"
      ;;
    8)
      echo -n "▇"
      ;;
    *)
      echo -n "█"
      ;;
  esac
}

# vim ft=sh
