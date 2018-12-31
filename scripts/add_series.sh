#!/bin/bash -l

while :; do
    flexget execute --no-cache --task series_seen_add
    flexget execute --no-cache --task series_unseen_add
    sleep 28800
done

