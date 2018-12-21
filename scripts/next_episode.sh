#!/bin/bash

# netcat http server
while :; do 
    series=$(nc -q1 -l -p 8082)
    echo got $series
    flexget execute --now --task episode_next_trakt 2>/dev/null | grep -m 1 -i -o -P -m 1 ".*$series.*\|\-\| \KS[0-9]*E[0-9]*" | nc -q1 localhost 8082
    sleep 1
done
