#!/usr/bin/env bash

UPS_NAME='ups'

PATH=$PATH:/usr/bin:/bin
TMP=$(upsc $UPS_NAME 2>/dev/null)

for value in "battery\.charge: [0-9.]+" "battery\.(runtime\.)?low: [0-9]+" "battery\.runtime: [0-9]+" "battery\.voltage: [0-9.]+" "battery\.voltage\.nominal: [0-9]+" "input\.voltage\.nominal: [0-9.]+" "input\.voltage: [0-9.]+" "ups\.load: [0-9.]+"
do
	OUT=$(echo $TMP | grep -Eo "$value" | awk '{print $2}' | LANG=C sort | head -n 1)
	if [ -n "$OUT" ]; then
		echo $OUT
	else
		echo "Unknown"
	fi

done