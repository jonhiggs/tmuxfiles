REDIS_CMD="redis-cli -s /tmp/redis.sock"

get_data_from_cache() {
  key=$1
  data=$(${REDIS_CMD} get ${key})
  if [[ -n "${data}" ]]; then
    echo ${data}
    return 0
  else
    return 1
  fi
}

cache_data() {
  key=$1
  data=$2
  expiration=$3

  ${REDIS_CMD} set "${key}" "${data}" &> /dev/null
  ${REDIS_CMD} expire "${key}" "${expiration}" &> /dev/null
}
