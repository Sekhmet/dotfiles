#!/usr/bin/env bash


wid=$1

title=$(xtitle "$1")

[[ "$title" == 'Emulator'* ]] \
    && echo state=floating
