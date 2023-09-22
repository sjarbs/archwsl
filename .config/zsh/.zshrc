#!/bin/zsh

# https://github.com/zplug/zplug
source /usr/share/zsh/scripts/zplug/init.zsh
  zplug "lib/*",                              from:oh-my-zsh
  zplug "plugins/archlinux",                  from:oh-my-zsh
  zplug "plugins/command-not-found",          from:oh-my-zsh
  zplug "plugins/common-aliases",             from:oh-my-zsh
  zplug "plugins/git",                        from:oh-my-zsh
  zplug "plugins/gh",                         from:oh-my-zsh
  zplug "plugins/pass",                       from:oh-my-zsh
  zplug "zsh-users/zsh-syntax-highlighting",  defer:2
  zplug "zsh-users/zsh-autosuggestions",      defer:2
  zplug "baliestri/pnpm.plugin.zsh",          defer:2
  zplug "jirutka/zsh-shift-select",           defer:2
zplug load

# Keybindings
# [Ctrl-Backspace] - delete whole backward-word
bindkey -M emacs '^H' backward-kill-word

# Aliases
source $ZDOTDIR/aliasrc

# Theme
eval "$(starship init zsh)"
