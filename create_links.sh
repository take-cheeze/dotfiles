#!/usr/bin/env bash

cd $(dirname $0)
mkdir -p ~/.emacs.d
for i in bashrc emacs.el gitconfig gitignore emacs.d/eww-bookmarks tmux.conf gemrc bazelrc pythonrc.py gdbinit; do
    rm -f ~/.$i
    echo "linking: $i"
    ln -s "$PWD/.$i" ~/.$i
done
