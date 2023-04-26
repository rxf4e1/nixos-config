#!/usr/bin/env sh
# wrapper script for sway notification center

USER_CONFIG_PATH="${HOME}/.config/swaync/config.json"
USER_STYLE_PATH="${HOME}/.config/swaync/style.css"

if [ -f "$USER_CONFIG_PATH" ];
then
  USER_CONFIG=$USER_CONFIG_PATH
fi

if [ -f "$USER_STYLE_PATH" ];
then
  USER_STYLE=$USER_STYLE_PATH
fi


swaync --style "${USER_STYLE}" --config "${USER_CONFIG}"
