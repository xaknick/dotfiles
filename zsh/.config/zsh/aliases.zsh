#!/bin/sh
alias v="nvim"
alias ls="eza -a -1 --group-directories-first"
alias mc="mc -u"
alias lg="lazygit"

vc() {
  local cfg="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
  builtin cd -- "$cfg" || return
  nvim .
}
