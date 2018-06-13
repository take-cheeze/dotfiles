#!/usr/bin/env bash

cd $(dirname $0)
for i in bashrc emacs.el gitconfig gitignore; do
    rm -f ~/.$i
    ln -s $PWD/.$i ~/.$i
done
