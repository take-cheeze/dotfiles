#!/usr/bin/env bash

set -eux

cd $(dirname $0)

command -v nix || sh <(curl -L https://nixos.org/nix/install) --daemon

./create_links.sh
rm -f ~/.bashrc ~/.profile

if ! command -v home-manager ; then
    nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
    nix-channel --update

    nix-shell '<home-manager>' -A install

    set +u
    . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
    set -u
fi

home-manager switch
./create_links.sh 
