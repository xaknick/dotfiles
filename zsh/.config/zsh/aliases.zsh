#!/bin/sh
alias v="nvim"
alias ls="eza -a -1 --group-directories-first"
alias mc="mc -u"
alias lg="lazygit"
alias z="zellij"

tr() { wezterm cli set-tab-title "$*"; }

vc() {
  local cfg="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
  builtin cd -- "$cfg" || return
  nvim .
}

# Fix for Claude Code: force-pass the current PATH to the process.
# This resolves 'Exit code 127' issues where Claude cannot find git or other utilities
# because it launches subshells in a "clean" environment without loading your .zshrc.
alias claude='PATH="$PATH" claude'
