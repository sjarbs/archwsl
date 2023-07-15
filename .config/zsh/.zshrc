#!/bin/zsh

# https://github.com/zplug/zplug
source /usr/share/zsh/scripts/zplug/init.zsh
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  zplug "zsh-users/zsh-autosuggestions", defer:2
  zplug "plugins/git", from:oh-my-zsh
  zplug "plugins/command-not-found", from:oh-my-zsh
  zplug "plugins/common-aliases", from:oh-my-zsh
zplug load

# Aliases
source $ZDOTDIR/aliasrc

# Theme
eval "$(starship init zsh)"
