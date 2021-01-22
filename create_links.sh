#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"
mkdir -p ~/.emacs.d
for i in bashrc bash_aliases emacs.el gitconfig gitignore emacs.d/eww-bookmarks tmux.conf gemrc bazelrc pythonrc.py gdbinit wl folders config/direnv/direnvrc Xmodmap xprofile ssh/rc profile zshrc brew-aliases; do
    rm -f ~/.$i
    mkdir -p "$(dirname ~/.$i)"
    echo "linking: $i"
    ln -s "$PWD/.$i" ~/.$i
done
