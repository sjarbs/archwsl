# Manjaro
> Manjaro XFCE After Install

## GPG 
> Do it before Before Dotfiles!
```sh
yay -S gnupg
mkdir -p ~/.local/share/gnupg # To prevent ownership issues: mkdir $GNUPGHOME
gpg --import private.asc
gpg --edit-key <KEY_ID>
# gpg> trust
# gpg> 5
# gpg> y
# gpg> quit
```

## Fonts
```sh
yay -S noto-fonts
yay -S ttf-jetbrains-mono
yay -S noto-fonts-emoji-apple
yay -S ttf-nerd-fonts-symbols-mono
```

## Restore Dotfiles
```sh
yay -S stow antigen
git clone https://github.com/sjarbs/dotfiles ~/Dotfiles
cd ~/Dotfiles && stow .

yay -S pass
git clone https://github.com/sjarbs/password-store ~/.local/share/password-store # $PASSWORD_STORE_DIR
cp -r $BACKUP/.mozilla ~/
```

## Runtimes
```sh
yay -S asdf-vm

asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs
asdf install nodejs

asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby
asdf install ruby
```