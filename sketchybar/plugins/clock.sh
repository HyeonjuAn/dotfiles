#!/usr/bin/env sh
source "$HOME/.config/sketchybar/icons.sh"

ICON="$ICON_CLOCK"
LABEL=$(date '+%I:%M %p')
# LABEL=$(date '+%H:%M:%S')
sketchybar --set $NAME icon="$ICON" label="$LABEL"
