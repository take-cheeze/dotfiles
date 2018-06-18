#!/usr/bin/env bash

cd $(dirname $0)
for i in bashrc emacs.el gitconfig gitignore emacs.d/eww-bookmarks; do
    rm -f ~/.$i
    echo "linking: $i"
    ln -s $PWD/.$i ~/.$i
done
