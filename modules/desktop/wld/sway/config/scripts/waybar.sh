#!/usr/bin/env sh
# wrapper script for waybar with args, see https://github.com/swaywm/sway/issues/5724

USER_CONFIG_PATH=$HOME/.config/waybar/config.jsonc
USER_STYLE_PATH=$HOME/.config/waybar/style.css

if [ -f "$USER_CONFIG_PATH" ]; then
    USER_CONFIG=$USER_CONFIG_PATH
fi

if [ -f "$USER_STYLE_PATH" ]; then
    USER_STYLE=$USER_STYLE_PATH
fi

waybar -c "${USER_CONFIG:-"/nix/store/*waybar*/etc/xdg/waybar/config.jsonc"}" -s "${USER_STYLE:-"/nix/store/*waybar*/etc/xdg/waybar/style.css"}" &
