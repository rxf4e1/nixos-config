#!/usr/bin/env sh

USER_CONFIG_PATH="$HOME/.config/dunst/dunstrc"

if [ -f "$USER_CONFIG_PATH" ]; then
  USER_CONFIG=$USER_CONFIG_PATH
fi

dunst -conf "${USER_CONFIG:-"/nix/store/*dunst*/etc/dunst/dunstrc"}" "$@"
