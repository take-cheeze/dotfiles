if command -v direnv 2>/dev/null >/dev/null; then
    eval "$(direnv hook zsh)"

    function virtualenv_prompt_info(){
        [[ -n ${VIRTUAL_ENV} ]] || return
        echo "${ZSH_THEME_VIRTUALENV_PREFIX:=[}${VIRTUAL_ENV:t}${ZSH_THEME_VIRTUALENV_SUFFIX:=]}"
    }
    export VIRTUAL_ENV_DISABLE_PROMPT=1

    plugins=(git virtualenv)
fi

if command -v brew >/dev/null 2>/dev/null ; then
    HOMEBREW_PREFIX="$(brew --prefix)"
    alias b=brew
    export PATH=$HOMEBREW_PREFIX/opt/ccache/libexec:$HOMEBREW_PREFIX/bin:$PATH

    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

    autoload -Uz compinit
    compinit
fi
