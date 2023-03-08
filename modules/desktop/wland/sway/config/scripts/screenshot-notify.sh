#!/usr/bin/env sh

# DEPS: inotify-tools

set -e

DIR=${XDG_SCREENSHOTS_DIR:-$HOME/pic/ss}

while true; do
  mkdir -pv "$DIR" && inotifywait -q -e create "$DIR" --format '%w%f' | xargs notify-send "Screenshot saved"
