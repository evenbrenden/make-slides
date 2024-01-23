#! /usr/bin/env nix-shell
#! nix-shell -p pandoc -p texlive.combined.scheme-small -i bash

# No emojis though 😞
pandoc -t beamer slides.md -o slides.pdf
