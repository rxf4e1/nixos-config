#!/usr/bin/env zsh

print -rl -- ${(ko)commands} | fzf-tmux -p --reverse | (nohup ${SHELL:-"/usr/bin/env sh"} &) >/dev/null 2>&1
