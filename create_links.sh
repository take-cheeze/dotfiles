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
    claude/settings.json \
    config/direnv/direnvrc \
    config/mpv/mpv.conf \
    config/nix/nix.conf \
    config/nixpkgs/config.nix \
    config/home-manager/home.nix \
    emacs.d/eww-bookmarks \
    emacs.el \
    folders \
    gdbinit \
    gemrc \
    gitconfig \
    gitignore \
    git_template \
    pi/agent/models.json \
    profile \
    pythonrc.py \
    ssh/rc \
    tmux.conf \
    wl \
    xprofile \
    zprofile \
    zshrc \
    ; do
    # -e follows symlinks, so it misses a dangling one (e.g. pointing at a
    # sibling checkout this machine doesn't have) and ln then fails on it
    # still occupying the path; -L catches the symlink itself either way.
    if [ -e ~/.$i ] || [ -L ~/.$i ] ; then
        rm ~/.$i
    fi
    mkdir -p "$(dirname ~/.$i)"
    echo "linking: $i"
    ln -s "$PWD/.$i" ~/.$i
done
