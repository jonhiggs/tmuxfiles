URL="http://reg.bom.gov.au/fwo/IDV60901/IDV60901.95936.json"
CACHE_DURATION=1200
REDIS_CMD="redis-cli"

get_data() {
  data=$(${REDIS_CMD} get weather_data)
  if [[ -n "${data}" ]]; then
    echo ${data}
    return 0
  fi

  data=$(curl ${URL} 2> /dev/null | jq '.observations.data[0]')
  ${REDIS_CMD} set weather_data "${data}"
  ${REDIS_CMD} expire weather_data ${CACHE_DURATION}
  echo ${data}
}
