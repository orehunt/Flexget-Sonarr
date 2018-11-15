#!/bin/bash

apikey=${SONARR_APIKEY}
host=localhost:8989

series_to_remove(){
    seriesIds=$(curl -s -X GET "$host/api/Series?apikey=$apikey" | jq -r '.[] | "\(.title) |-| \(.id)" ')
    list=series.txt
    echo -n '' > $list

    IFS=$'\n'
    for s in $seriesIds; do
        id=${s/*|-| }
        title=${s/ |-|*}
        monitored=$(curl -s -X GET "$host/api/episode?apikey=${apikey}&seriesId=$id" | jq '.[] | select(.monitored == true ) | .id ')
        monitored_count=$(echo -n "$monitored" | wc -l)
        if [ "$monitored_count" = 0 ]; then
            echo "$title" >> $list
        fi
    done
}

while :; do
    series_to_remove
    flexget execute --no-cache --task seen_series_remove
    sleep 28800
done

