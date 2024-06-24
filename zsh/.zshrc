#!/bin/sh
# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

# Load and initialise completion system
autoload -Uz compinit
compinit

# history
HISTFILE=~/.zsh_history

# source and plugins
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$ZSH_PLUGINS/*"

# Starship promt
eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
# Fedora has an old version of fzf, so I need to configure it manually
# RPM bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2256379
# Fzf issue: https://github.com/junegunn/fzf/issues/3827
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Configuration for Fedora
  if [[ -f /usr/share/fzf/shell/key-bindings.zsh ]]; then
    source /usr/share/fzf/shell/key-bindings.zsh
  fi

  if [[ -f /usr/share/fzf/shell/completion.zsh ]]; then
    source /usr/share/fzf/shell/completion.zsh
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # Configuration for macOS
  source <(fzf --zsh)
fi
