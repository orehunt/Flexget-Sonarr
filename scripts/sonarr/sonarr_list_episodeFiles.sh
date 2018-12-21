#!/bin/bash -l

apikey=4f3a98b538594bd8a58f162fb4cce2b5
host=localhost:8989
sleep=600

series=$(curl -s -X GET "$host/api/Series?apikey=$apikey" | jq -r '.[] | "\(.title) |-| \(.id)"')

IFS=$'\n'
for s in $series; do
    title=${s/ |-|*}
    id=${s/*|-| }
    curl -s -X GET "$host/api/EpisodeFile/?seriesId=${id}&apikey=$apikey"
done

