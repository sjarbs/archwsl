# archwsl

## wsl

```powershell
# enable WSL (or use CTT Tool)
sudo dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
sudo dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# reboot
sudo wsl --update
sudo wsl --set-default-version 2
scoop install archwsl # or `winget install -e --id 9MZNMNKSM73X` # Arch WSL

# if it was already installed then:
wsl --set-version Arch 2
```

## initialize

[read more...](https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/)

```sh
# enter from powershell
Arch.exe
# root password
passwd

# default user
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
useradd -m -G wheel -s /bin/bash sj
passwd sj
exit
Arch.exe config --default-user sj

# keyring
Arch.exe
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Syy archlinux-keyring

# pacman eyecandy (not included in dotfiles because is a root config)
alias i="sudo pacman --sync --needed --noconfirm"
i micro

# locale (otherwise perl cries)
sudo sed --in-place 's/^#en_US\.UTF-8/en_US\.UTF-8/' /etc/locale.gen # uncomment
locale-gen
```

## yay

```sh
i base-devel git
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si # (doesnt work in WSL1)
cd .. && rm -rf yay-bin
# reflector
yay --noconfirm
```

## programs

```sh
alias i="yay --sync --needed --noconfirm" # --nodiffmenu --nocleanmenu
i zsh stow zplug starship # prompt
i htop micro man-db man-pages # tuis
i wget moreutils lsd trash-cli fzf bat pfetch pass ffmpeg yt-dlp p7zip # clis
i git gnupg github-cli pnpm-bin nodejs-lts-gallium # dev
```

## dotfiles

```sh
chsh -s /bin/zsh # logout and login
gh auth login
git clone https://github.com/sjarbs/archwsl ~/dotfiles
mkdir -p ~/.local/share/gnupg
cd ~/dotfiles && stow --adopt .
zplug install
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

# fix `gpg: WARNING: unsafe permissions on homedir`
# https://gist.github.com/oseme-techguy/bae2e309c084d93b75a9b25f49718f85#gistcomment-3585593
find $GNUPGHOME -type f -exec chmod 600 {} \;
find $GNUPGHOME -type d -exec chmod 700 {} \;
```

## fonts

```powershell
scoop bucket add nerd-fonts
scoop install JetBrainsMono-NF
```
