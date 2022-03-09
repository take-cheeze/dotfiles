CASE_SENSITIVE="true"

if command -v direnv 2>/dev/null >/dev/null; then
    eval "$(direnv hook zsh)"

    function virtualenv_prompt_info(){
        [[ -n ${VIRTUAL_ENV} ]] || return
        echo "${ZSH_THEME_VIRTUALENV_PREFIX:=[}${VIRTUAL_ENV:t}${ZSH_THEME_VIRTUALENV_SUFFIX:=]}"
    }
    export VIRTUAL_ENV_DISABLE_PROMPT=1

    plugins=(git virtualenv)
fi

export PATH=$PATH:/opt/homebrew/bin:$HOME/.local/bin

if command -v brew >/dev/null 2>/dev/null ; then
    HOMEBREW_PREFIX="$(brew --prefix)"
    export PATH=$HOMEBREW_PREFIX/opt/ccache/libexec:$PATH

    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

    autoload -Uz compinit
    compinit
fi

if command -v rbenv >/dev/null ; then
    eval "$(rbenv init -)"
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export MAKEFLAGS=$(nproc)
