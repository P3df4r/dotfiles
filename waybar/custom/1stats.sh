#!/bin/bash

swaymsg workspace stats
if [ "$1" == "cpu" ]; then
    tilix btop
    exit
fi

if [ "$1" == "memory" ]; then
    tilix btop
    exit
fi

tilix btop
exit
