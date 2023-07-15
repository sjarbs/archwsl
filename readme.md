# Arch Linux WSL Setup Guide

This guide provides instructions for setting up Arch Linux on WSL (Windows Subsystem for Linux). Follow the steps below to install and configure Arch Linux WSL on your Windows machine.

## [WSL Installation](https://learn.microsoft.com/en-us/windows/wsl/install-manual)

Open PowerShell and run the following commands:

```powershell
# Enable WSL
sudo dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
sudo dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
Restart-Computer

# Set WSL version 2 as default
wsl --update
wsl --set-default-version 2

# Install Arch Linux WSL using Scoop package manager
scoop install archwsl
```

## Initialization

Follow these steps to initialize your Arch Linux WSL:

```sh
Arch.exe # Enter from PowerShell
passwd   # Set root password

# Keyring
pacman-key --init
pacman-key --populate
pacman -Syy archlinux-keyring
pacman -Su

# Mirrorlist
pacman --sync --needed --noconfirm reflector rsync
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist

# Locale (required for Perl)
sed --in-place 's/^#en_US\.UTF-8/en_US\.UTF-8/' /etc/locale.gen # Uncomment
locale-gen

# Create a default user
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
pacman --sync --needed --noconfirm zsh
useradd -m -G wheel -s /bin/zsh sj
passwd sj
exit
Arch.exe config --default-user sj
```

## yay (AUR Helper)

Install `yay`, an AUR helper, with the following commands:

```sh
sudo pacman --sync --needed --noconfirm base-devel git
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd .. && rm -rf yay-bin
yay --noconfirm
```

## Installing Programs

Use the following commands to install various programs:

```sh
# Prompt and shell-related
yay -S --needed --noconfirm zsh stow zplug starship

# TUIs
yay -S --needed --noconfirm htop micro man-db man-pages

# Command-line utilities
yay -S --needed --noconfirm wget moreutils lsd trash-cli fzf bat pfetch pass ffmpeg yt-dlp p7zip

# Development-related
yay -S --needed --noconfirm git gnupg github-cli nodejs-lts-hydrogen pnpm
```

## WSL Utilities

To install `wslu` ([WSL Utilities](https://wslutiliti.es/wslu/)), follow these steps:

```sh
wget https://pkg.wslutiliti.es/public.key
sudo pacman-key --add public.key && rm public.key
sudo pacman-key --lsign-key 2D4C887EB08424F157151C493DD50AA7E055D853
echo -e "\n# https://wslutiliti.es/wslu/\n[wslutilities]\nServer = https://pkg.wslutiliti.es/arch/" | sudo tee -a /etc/pacman.conf
yay -Sy --noconfirm && yay -S --noconfirm wslu
```

## Create Directories

Create the following directories to prevent unwanted file tracking and permission warnings:

```sh
mkdir -p ~/.local/share/gnupg # `gpg: WARNING: unsafe permissions on homedir`
mkdir -p ~/.config/micro      # https://github.com/zyedidia/micro/issues/2004
```

## Dotfiles

Set up the dotfiles provided in this repository:

```sh
gh auth login
git clone https://github.com/sjarbs/archwsl ~/dotfiles
cd ~/dotfiles && stow --adopt .
zplug install
```

## GPG Configuration

Configure GPG by executing the following commands:

```sh
git clone https://github.com/sjarbs/keys /tmp/keys
mv ~/.gnupg $GNUPGHOME
gpg --import /tmp/keys/private.asc && rm -rf /tmp/keys
gpg --edit-key <KEY_ID> # Press Tab for autocompletion
# gpg> trust
# gpg> 5
# gpg> y
# gpg> quit

# Fix `gpg: WARNING: unsafe permissions on homedir`
# See: https://gist.github.com/oseme-techguy/bae2e309c084d93b75a9b25f49718f85#gistcomment-3585593
find $GNUPGHOME -type f -exec chmod 600 {} \;
find $GNUPGHOME -type d -exec chmod 700 {} \;
```

## Fonts

Install Nerd Fonts using the following PowerShell commands:

```powershell
scoop bucket add nerd-fonts
scoop install JetBrainsMono-NF
```

## VSCode Integration

To resolve the `HISTFILE` [issue](https://stackoverflow.com/questions/74764599/histfile-in-integrated-terminal-not-the-same-as-normal-terminal) in VSCode's Zsh shell integration, add the following line to your `.vscode/settings.json` file:

```json
{
  "terminal.integrated.shellIntegration.enabled": false
}
```
