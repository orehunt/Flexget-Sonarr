#!/bin/bash

while :; do
	  flexget execute --no-cache --now --task done_series_remove dropped_series_remove
        sleep 86400
done
