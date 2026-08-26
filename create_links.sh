#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"
mkdir -p ~/.emacs.d
for i in \
    Xmodmap \
    bash_aliases \
    bashrc \
    bazelrc \
    brew-aliases \
    claude/settings.json \
    config/direnv/direnvrc \
    config/mpv/mpv.conf \
    config/nix/nix.conf \
    config/nixpkgs/config.nix \
    config/home-manager/home.nix \
    config/opencode/opencode.json \
    config/opencode/plugin/zundamon-tts.js \
    emacs.d/eww-bookmarks \
    emacs.el \
    folders \
    gdbinit \
    gemrc \
    gitconfig \
    gitignore \
    git_template \
    local/bin/claude-tts-speak \
    profile \
    pythonrc.py \
    ssh/rc \
    tmux.conf \
    wl \
    xprofile \
    zprofile \
    zshrc \
    ; do
    # -e follows symlinks, so it misses a dangling one (e.g. pointing at a
    # sibling checkout this machine doesn't have) and ln then fails on it
    # still occupying the path; -L catches the symlink itself either way.
    if [ -e ~/.$i ] || [ -L ~/.$i ] ; then
        rm ~/.$i
    fi
    mkdir -p "$(dirname ~/.$i)"
    echo "linking: $i"
    ln -s "$PWD/.$i" ~/.$i
done

# The opencode-tts plugin's edge_tts.command doesn't expand ~, so this one
# config can't just be symlinked like the rest -- generate it with $HOME
# resolved instead.
mkdir -p ~/.config/opencode/plugins
cat > ~/.config/opencode/plugins/opencode-tts.jsonc <<EOF
{
  "enabled": true,
  "mode": "summary",
  "backend": "edge_tts",
  "edge_tts": {
    "command": ["$HOME/.local/bin/tts-forward"],
    "voice": "zundamon:normal",
    "rate": "+10%"
  }
}
EOF

mkdir -p ~/.local/bin
curl -fsSL https://tts-tts-ingress.tailf0b7b1.ts.net/install/tts-forward -o ~/.local/bin/tts-forward
chmod +x ~/.local/bin/tts-forward
