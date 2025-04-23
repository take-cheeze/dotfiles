alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias be='bundle exec'
alias dc='docker compose'
alias b='brew'
alias d='docker'
alias g='git'
alias gg='git grep'
alias k='kubectl'
alias emacs='emacs -nw'
alias c='code'
alias py='PYTHONSTARTUP=~/.pythonrc.py python3'
if ! command -v nproc >/dev/null ; then
    alias nproc="sysctl -n hw.logicalcpu"
fi
alias tf=terraform

export CTEST_PARALLEL_LEVEL="$(nproc)"
export MAKEFLAGS="-j$(nproc)"

command -v arduino-cli 2>/dev/null >/dev/null && eval "$(arduino-cli completion $SHELL)"
command -v npm >/dev/null 2>/dev/null && eval "$(npm completion)"
if command -v kubectl > /dev/null ; then
    . <(kubectl completion $(basename $SHELL))
    test -v BASH && complete -o default -F __start_kubectl k
fi
command -v glab >/dev/null 2>/dev/null && eval "$(glab completion)"
command -v faas-cli >/dev/null 2>/dev/null && eval "$(faas-cli completion --shell $(basename $SHELL))"
command -v helm >/dev/null 2>/dev/null && eval "$(helm completion $(basename $SHELL))"
if command -v docker >/dev/null 2>/dev/null ; then
    eval "$(docker completion $(basename $SHELL))"
    test -v BASH && complete -o default -F __start_docker d
fi
