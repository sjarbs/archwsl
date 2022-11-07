# archwsl

## wsl

```powershell
sudo dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
sudo dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
# reboot
sudo wsl --update
sudo wsl --set-default-version 2
scoop install archwsl
```

## initialize

[read more...](https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/)

```sh
# root password
passwd

# default user
pacman -S --needed zsh
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
useradd -m -G wheel -s /bin/zsh sj
passwd sj
exit
Arch.exe config --default-user sj

# keyring
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Syy archlinux-keyring
```

## yay

```sh
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd .. && rm -rf yay-bin
yay
```

## programs

```sh
alias install="yay --sync --needed --nodiffmenu --nocleanmenu --noconfirm"
install zsh stow antigen starship
install wget moreutils lsd trash-cli fzf bat pfetch
install git gnupg github-cli pnpm-bin nodejs-lts-gallium
```

## dotfiles

```sh
gh auth login
git clone https://github.com/sjarbs/archwsl ~/dotfiles
cd ~/dotfiles && stow --adopt .
```

## gpg

```sh
git clone https://github.com/sjarbs/keys /tmp/keys
mv ~/.gnupg $GNUPGHOME
gpg --import /tmp/keys/private.asc && rm -rf /tmp/keys
gpg --edit-key <KEY_ID>
# gpg> trust
# gpg> 5
# gpg> y
# gpg> quit
```

## fonts

```powershell
scoop bucket add nerd-fonts
scoop install JetBrainsMono-NF
```
