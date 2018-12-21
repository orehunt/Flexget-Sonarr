#!/bin/bash -l

apikey=${SONARR_APIKEY}
host=localhost:8989

while :; do
	flexget execute --now --no-cache --task seen_episodes_delete
        curl -s -X POST "$host/api/command?apikey=$apikey" -d '{"name": "rescanSeries"}'
        sleep 3600
done
