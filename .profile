# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ] ; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix.sh ] ; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
fi

if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ] ; then
    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

[ -d "$HOME/.anyenv" ] && export PATH="$HOME/.anyenv/bin:$PATH"
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
if [ -e "$HOME/.cargo/env" ] ; then
    source "$HOME/.cargo/env"
elif [ -d "$HOME/.cargo/bin" ] ; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi
[ -d /opt/homebrew/bin ] && export PATH=/opt/homebrew/bin:$PATH

export PYTHON_CONFIGURE_OPTS="--enable-shared"
if command -v pyenv 2> /dev/null > /dev/null ; then
    eval "$(pyenv init -)"
    if [ ! -d "$(pyenv root)/plugins/pyenv-virtualenv" ] ; then
        git clone https://github.com/pyenv/pyenv-virtualenv.git "$(pyenv root)/plugins/pyenv-virtualenv"
    fi
    eval "$(pyenv virtualenv-init -)"
fi

command -v anyenv 2> /dev/null > /dev/null && eval "$(anyenv init -)"
command -v rbenv 2> /dev/null > /dev/null && eval "$(rbenv init -)"
command -v direnv 2>/dev/null >/dev/null && eval "$(direnv hook $SHELL)"
command -v krew 2>/dev/null >/dev/null && export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export GOPATH="$HOME/dev/go"
export PATH="$GOPATH/bin:node_modules/.bin:$PATH"
