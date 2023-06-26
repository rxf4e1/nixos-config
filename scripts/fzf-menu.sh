#!/usr/bin/env bash
#
# ./fzf-menu.sh

fd . /etc/profiles/per-user/rxf4e1/bin | \
  fzf-tmux -p -- -e -i -m --reverse --delimiter / --with-nth -1 | \
  $(eval ${SHELL:-"/usr/bin/env sh"} &) >/dev/null 2>&1
