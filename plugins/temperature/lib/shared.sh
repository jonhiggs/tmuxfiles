OBSERVATIONS_URL="http://reg.bom.gov.au/fwo/IDV60901/IDV60901.95936.json"
FORECAST_URL="ftp://ftp.bom.gov.au/anon/gen/fwo/IDV10751.xml"
CACHE_DURATION=600
REDIS_CMD="redis-cli -s /tmp/redis.sock"

get_observation_data() {
  local data
  data=$(${REDIS_CMD} get weather_observation_data)
  if [[ -n "${data}" ]]; then
    echo ${data}
    return 0
  fi

  data=$(curl ${OBSERVATIONS_URL} 2> /dev/null | jq '.observations.data[0]')
  ${REDIS_CMD} set weather_observation_data "${data}"
  ${REDIS_CMD} expire weather_observation_data ${CACHE_DURATION}
  echo ${data}
}

get_forcast_data() {
  local data
  data=$(${REDIS_CMD} get weather_forecast_data)
  if [[ -n "${data}" ]]; then
    echo ${data}
    return 0
  fi

  ${REDIS_CMD} set weather_forecast_data "${data}"
  ${REDIS_CMD} expire weather_forecast_data ${CACHE_DURATION}
  echo ${data}
}
