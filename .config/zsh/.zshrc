# Theme
SPACESHIP_CHAR_SYMBOL="▲"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_EXEC_TIME_PREFIX="⌚ "

# Antigen
source /usr/share/zsh/share/antigen.zsh
  antigen use oh-my-zsh
  antigen bundle git
  antigen bundle npm
  antigen bundle poetry
  antigen bundle command-not-found
  antigen bundle common-aliases
  antigen bundle zsh-users/zsh-syntax-highlighting
  antigen bundle zsh-users/zsh-autosuggestions
  antigen theme denysdovhan/spaceship-prompt
antigen apply

source $ZDOTDIR/aliasrc

eval "$(fnm env)"
. /opt/asdf-vm/asdf.sh

# Fix: 'ERROR: UtilConnectToInteropServer:300: connect failed 2'
# https://github.com/microsoft/WSL/issues/5065#issuecomment-682198412
fix_wsl2_interop() {
    for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
        if [[ -e "/run/WSL/${i}_interop" ]]; then
            export WSL_INTEROP=/run/WSL/${i}_interop
        fi
    done
}
fix_wsl2_interop