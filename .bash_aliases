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
