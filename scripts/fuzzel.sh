#!/usr/bin/env sh

# fuzzel --font cozette:size=10 \
#        --terminal foot \
#        --width 64 \
#        --background-color=01180bff \
#        --text-color=7dea2aff \
#        --match-color=2aea9dff \
#        --selection-color=01180bff \
#        --selection-text-color=e64343ff \
#        --border-width=2 \
#        --border-radius=0 \
#        --border-color=7dea2aff \
#        --no-icons \
#        $@ <&0


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
       -C 8e8e8eff \
       -I \
       $@ <&0
