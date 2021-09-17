# archwsl
> archwsl after install

## GPG 
```sh
yay -S gnupg
GNUPGHOME="~/.local/share/gnupg"
mkdir -p $GNUPGHOME # To prevent ownership issues
gpg --import private.asc
gpg --edit-key <KEY_ID>
# gpg> trust
# gpg> 5
# gpg> y
# gpg> quit
```

## Dotfiles
```sh
yay -S stow antigen
git clone https://github.com/sjarbs/archwsl ~/dotfiles
cd ~/dotfiles && stow .

## Password Store
yay -S pass
PASSWORD_STORE_DIR="~/.local/share/password-store"
git clone https://github.com/sjarbs/password-store $PASSWORD_STORE_DIR
```

## Install
```
antigen
exa
fnm-bin
github-cli
htop
micro
pass
reflector
rsync
trash-cli
yay-bin
```