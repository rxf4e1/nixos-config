#!/usr/bin/env sh

fuzzel -f cozette:size=10 \
       -T footclient \
       -w 64 \
       -b 0f0e0fff \
       -t abaeacff \
       -m ffd700ff \
       -s daa520ff \
       -S 000000ff \
       -B 2 \
       -r 0 \
       -C 8e8e8eff $@ <&0
