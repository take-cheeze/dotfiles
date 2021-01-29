#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"
mkdir -p ~/.emacs.d
for i in \
    Xmodmap \
    bash_aliases \
    bashrc \
    bazelrc \
    brew-aliases \
    config/direnv/direnvrc \
    emacs.d/eww-bookmarks \
    emacs.el \
    folders \
    gdbinit \
    gemrc \
    gitconfig \
    gitignore \
    profile \
    pythonrc.py \
    ssh/rc \
    tmux.conf \
    wl \
    xprofile \
    zshrc \
    ; do
    rm ~/.$i
    mkdir -p "$(dirname ~/.$i)"
    echo "linking: $i"
    ln -s "$PWD/.$i" ~/.$i
done
