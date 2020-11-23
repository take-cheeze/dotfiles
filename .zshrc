if command -v brew >/dev/null 2>/dev/null ; then
    HOMEBREW_PREFIX="$(brew --prefix)"
    alias b=brew
    export PATH=$HOMEBREW_PREFIX/opt/ccache/libexec:$HOMEBREW_PREFIX/bin:$PATH

    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

    autoload -Uz compinit
    compinit
fi
