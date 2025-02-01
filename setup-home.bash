#!/usr/bin/env bash

set -eux

cd $(dirname $0)

command -v nix || sh <(curl -L https://nixos.org/nix/install) --daemon

if ! command -v home-manager ; then
    nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
    nix-channel --update

    nix-shell '<home-manager>' -A install

    . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
fi

./create_links.sh
rm -f ~/.bashrc ~/.profile
home-manager switch
./create_links.sh 
