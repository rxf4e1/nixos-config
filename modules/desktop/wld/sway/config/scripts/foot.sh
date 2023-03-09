#!/usr/bin/env sh
# wrapper script for foot

USER_CONFIG_PATH="${HOME}/.config/foot/foot.ini"

if [ -f "$USER_CONFIG_PATH" ]; then
    USER_CONFIG=$USER_CONFIG_PATH
fi

foot -c "${USER_CONFIG:-"/nix/store/*foot*/etc/xdg/foot/foot.ini"}" "$@" &
