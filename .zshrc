#!/bin/zsh

# Default programs
export EDITOR="code"
export BROWSER="wslview"
export TERMINAL="windows-terminal"

# XDG Base Directory
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/run/user/$UID"

# XDG_RUNTIME_DIR
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# XDG_CACHE_HOME
export HISTFILE="$XDG_CACHE_HOME/zsh_history"
export LESSHISTFILE="-"
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/node_repl_history"
export ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority"

# XDG_CONFIG_HOME
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/.npmrc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh" # Broken in VSCode 1.70.1
export PYTHONSTARTUP="$XDG_CONFIG_HOME/pythonstartup.py"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"

# XDG_DATA_HOME
export ADOTDIR="$XDG_DATA_HOME/antigen"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
export BUNDLE_USER_HOME="$XDG_DATA_HOME/bundle"
export GOPATH="$XDG_DATA_HOME/go"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# PATH
export PATH="$PATH:$PNPM_HOME"
export PATH="$PATH:$HOME/.local/bin"

# Antigen
source /usr/share/zsh/share/antigen.zsh
  antigen use oh-my-zsh
  antigen bundle git
  antigen bundle command-not-found
  antigen bundle common-aliases
  antigen bundle zsh-users/zsh-syntax-highlighting
  antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# Aliases
# Dotfiles/OS
alias add="yay --sync --needed --nodiffmenu --nocleanmenu --noconfirm"
alias remove="yay -Rsu"
alias update="yay -Syu --nodiffmenu --nocleanmenu --noconfirm && antigen update"
#alias update="yay -Syu --nodiffmenu --nocleanmenu --noconfirm && antigen update && pipx upgrade-all && gem update shopify-cli"
alias yay-ls='comm -23 <(pacman -Qqett | sort) <(pacman -Qqg base -g base-devel | sort | uniq) | less'
# alias clean=clean # from .local/bin/clean
alias xclip='xclip -sel clip'
alias weight="du -hs"

# Git/Github
alias onefetch="onefetch --no-palette --show-logo never"
alias of="onefetch"
alias gi="gh issue list"
alias gr="git remote -v"
alias gs="git status"
alias gl="git log"

# Verbosity and better default settings.
alias \
  ls='lsd --almost-all --group-dirs=first' \
  cp="cp -iv" \
  mv="mv -iv" \
  md="mkdir -pv"
  df='df -h' \
  free='free -m' \

# Colorize commands when possible.
alias \
  grep="grep --color=auto" \
  diff="diff --color=auto" \

# Redshift
alias \
  r6='redshift -PO 6500' \
  r5='redshift -PO 5500' \
  r4='redshift -PO 4500' \
  r3='redshift -PO 3500' \
  r2='redshift -PO 2500' \
  r1='redshift -PO 1500' \

# cpufreq
alias \
  c08='sudo cpupower frequency-set --max  800MHz' \
  c13='sudo cpupower frequency-set --max 1300MHz' \
  c16='sudo cpupower frequency-set --max 1600MHz' \
  c19='sudo cpupower frequency-set --max 1900MHz' \


# Instaloader
alias stories='instaloader --login julito.xyz --no-posts --no-profile-pic --no-metadata-json --stories'

# Dev
alias npm='pnpm'
alias n='pnpm'
alias touch-package-json='echo "{ \"private\": true }" > package.json'
alias node-cli-boilerplate='curl -fsSL https://github.com/sobrinojulian/node-cli-boilerplate/archive/main.tar.gz | tar -xz --strip-components=1'
alias server='python -m http.server 8000'

# npm i *
alias ole='ole | less'
alias boca='aquehorajuegaboca | less'
alias xtw='xcolor-tailwind'

# functions
touch2() { mkdir -p "$(dirname "$1")" && touch "$1" ; }

# Theme
eval "$(starship init zsh)"
