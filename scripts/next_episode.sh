#!/bin/bash

cache=/tmp/episode_next_cache

# netcat http server
while :; do
    series=$(nc -q1 -l -p 8082)
    echo got $series
    [ -z "$(find "$cache" -mtime +1 -print)" ] || flexget execute --now --task episode_next_trakt 1>$cache
    grep -m 1 -i -o -P -m 1 ".*$series.*\|\-\| \KS[0-9]*E[0-9]*" "$cache" | nc -q1 localhost 8082
    sleep 1
done
