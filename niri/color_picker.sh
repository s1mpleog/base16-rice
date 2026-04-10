#!/bin/bash

COLOR=$(niri msg pick-color | grep Hex | cut -c 6-)                                   # Extracts the Hex code (e.g., #334242)
echo "$COLOR" | wl-copy -t text/plain                                                 # Copies the color to the clipboard
notify-send -a Colorpicker -i colorpicker -t 2000 "Color $COLOR copied to clipboard." # Optional: sends a notification
