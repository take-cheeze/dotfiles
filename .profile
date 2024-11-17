# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -e "$HOME/.cargo/env" ] ; then
    source "$HOME/.cargo/env"
fi

if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ] ; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix.sh ] ; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
fi

if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ] ; then
    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

alias py='PYTHONSTARTUP=~/.pythonrc.py python3'

if ! command -v nproc >/dev/null ; then
    alias nproc="sysctl -n hw.logicalcpu"
fi

if [ -d $HOME/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi

if command -v pyenv 2> /dev/null > /dev/null ; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

command -v rbenv 2> /dev/null > /dev/null && eval "$(rbenv init -)"

if command -v arduino-cli 2>/dev/null >/dev/null; then
    eval "$(arduino-cli completion $SHELL)"
fi

if command -v direnv 2>/dev/null >/dev/null; then
    eval "$(direnv hook $SHELL)"
fi

if [ -d /opt/homebrew/bin ] ; then
    export PATH=/opt/homebrew/bin:$PATH
fi

export MAKEFLAGS=-j$(nproc)
export CTEST_OUTPUT_ON_FAILURE=1
export CTEST_PARALLEL_LEVEL=$(nproc)

export GOPATH="$HOME/dev/go"
