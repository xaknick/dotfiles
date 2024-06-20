#!/bin/sh
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR=/usr/local/bin/nvim

# Path variables
export PATH="$HOME/.local/bin":$PATH

# Set Path for MacOS WezTerm
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS specific configuration
  PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
fi

# Starship config
export STARSHIP_CONFIG="$HOME/.config/zsh/starship.toml"
