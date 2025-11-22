#!/bin/sh
# Zap installer
ZAP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zap"
if [ ! -d "$ZAP_DIR" ]; then
  echo "Zap is not installed. Installing to $ZAP_DIR..."
  git clone --depth=1 https://github.com/zap-zsh/zap.git "$ZAP_DIR"
fi

# Source Zap
if [ -f "$ZAP_DIR/zap.zsh" ]; then
  source "$ZAP_DIR/zap.zsh"
else
  echo "Zap installation is incomplete. Please check $ZAP_DIR."
fi

# Zap plugins
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

# Load and initialise completion system
autoload -Uz compinit
# Optimizing slow compinit
if [[ -r ~/.zcompdump ]]; then
  zcompdump_cache=~/.zcompdump.$HOST
  if [[ ! -f $zcompdump_cache || ~/.zcompdump -nt $zcompdump_cache ]]; then
    compinit -u -d $zcompdump_cache
  else
    compinit -C -d $zcompdump_cache
  fi
else
  compinit &
fi

# history
HISTFILE=~/.zsh_history

# source and plugins
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/hotkeys.zsh"
plug "$ZSH_PLUGINS/*"

# Starship promt
eval "$(starship init zsh)"

# Edit the command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# fzf config
source <(fzf --zsh)

show_file_or_dir_preview="if [ -d {} ]; then eza --all --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --all --tree --color=always {} | head -200'"

# Zoxide config
eval "$(zoxide init --cmd cd zsh)"
export PATH=~/.npm-global/bin:$PATH
