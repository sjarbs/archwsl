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
### Fix `gpg: WARNING: unsafe permissions on homedir`
```sh
# https://gist.github.com/oseme-techguy/bae2e309c084d93b75a9b25f49718f85#gistcomment-3585593
find $GNUPGHOME -type f -exec chmod 600 {} \; # Set 600 for files
find $GNUPGHOME -type d -exec chmod 700 {} \; # Set 700 for directories
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

## pacman
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

## asdf
```
yay -S --needed coreutils curl
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
