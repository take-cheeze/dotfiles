# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoredups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=-1
HISTFILESIZE=-1

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color|eterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export PATH="$HOME/.local/bin:$GOPATH/bin:$HOME/.yarn/bin:/usr/lib/ccache:/usr/lib/ccache/bin:/usr/local/go/bin:$HOME/bin:/snap/bin:$PATH:/opt/rocm/bin:/opt/rocm/profiler/bin:/opt/rocm/opencl/bin/x86_64:$HOME/dev/mx:/usr/local/cuda/bin:$HOME/.dotnet/tools:$HOME/.platformio/penv/bin:node_modules/.bin"

if [ -e "$HOME/.cargo/env" ] ; then
    source "$HOME/.cargo/env"
fi

# if grep -qE "(microsoft|WSL)" /proc/version &> /dev/null ; then
#     export DISPLAY="$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0"
#     export LIBGL_ALWAYS_INDIRECT=1
# fi

if [ "$DISPLAY" != "" ] ; then
    source ~/.xprofile
fi

if [ -f ~/.bazel/bin/bazel-complete.bash ] ; then
    source ~/.bazel/bin/bazel-complete.bash
fi

if command -v keychain 2>/dev/null >/dev/null && [ -f ~/.ssh/id_ed25519 ] ; then
    keychain --nogui $HOME/.ssh/id_ed25519 2>/dev/null
    source "$HOME/.keychain/$HOSTNAME-sh"
fi

if command -v npm >/dev/null 2>/dev/null ; then
    source <(npm completion)
fi

export PYTHON_CONFIGURE_OPTS="--enable-shared"

if [ -f /usr/share/doc/pkgfile/command-not-found.bash ] ; then
    export PKGFILE_PROMPT_INSTALL_MISSING=1
    source /usr/share/doc/pkgfile/command-not-found.bash
fi

if command -v brew >/dev/null 2>/dev/null ; then
    HOMEBREW_PREFIX="$(brew --prefix)"
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
        for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
            [[ -r "$COMPLETION" ]] && source "$COMPLETION"
        done
    fi
fi

ulimit -c unlimited

