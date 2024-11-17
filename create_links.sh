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
    config/nix/nix.conf \
    config/home-manager/home.nix \
    emacs.d/eww-bookmarks \
    emacs.el \
    folders \
    gdbinit \
    gemrc \
    gitconfig \
    gitignore \
    git_template \
    profile \
    pythonrc.py \
    ssh/rc \
    tmux.conf \
    wl \
    xprofile \
    zprofile \
    zshrc \
    ; do
    if [ -e ~/.$i ] ; then
        rm ~/.$i
    fi
    mkdir -p "$(dirname ~/.$i)"
    echo "linking: $i"
    ln -s "$PWD/.$i" ~/.$i
done
