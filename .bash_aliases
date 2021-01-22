alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias be='bundle exec'
alias dc='docker-compose'
alias b='brew'
alias d='docker'
alias g='git'
alias k='kubectl'
alias emacs='emacs -nw'
alias remacs='remacs -nw'

if ! command -v nproc >/dev/null ; then
    alias nproc="sysctl -n hw.logicalcpu"
fi
