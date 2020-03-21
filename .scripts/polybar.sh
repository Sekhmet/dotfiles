#!/bin/bash

BAR="main"

MAIN_MONITORS=("HDMI-A-1" "eDP-1")

MONITORS=$(polybar --list-monitors)

for monitor in "${MAIN_MONITORS[@]}"
do
	echo $MONITORS | grep $monitor && MONITOR=$monitor polybar $BAR
done

