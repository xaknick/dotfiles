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

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# source and plugins
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$ZSH_PLUGINS/*"

# Starship promt
eval "$(starship init zsh)"

# fzf config
source <(fzf --zsh)

show_file_or_dir_preview="if [ -d {} ]; then eza --all --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --all --tree --color=always {} | head -200'"
