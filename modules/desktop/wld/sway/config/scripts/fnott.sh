#!/usr/bin/env sh
# wrapper script for mako

USER_CONFIG_PATH="${HOME}/.config/fnott/fnott.ini"

if [ -f "$USER_CONFIG_PATH" ]; then
    USER_CONFIG=$USER_CONFIG_PATH
fi

fnott -c "${USER_CONFIG}"
