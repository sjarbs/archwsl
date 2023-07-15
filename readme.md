# archwsl

## [wsl](https://learn.microsoft.com/en-us/windows/wsl/install-manual)

```powershell
# enable WSL
sudo dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
sudo dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
Restart-Computer
# then
wsl --update
wsl --set-default-version 2
scoop install archwsl
```

## [initialize](https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/)

```sh
Arch.exe # enter from powershell
passwd # set root password

# keyring
pacman-key --init
pacman-key --populate
pacman -Syy archlinux-keyring
pacman -Su

# mirrorlist
pacman --sync --needed --noconfirm reflector rsync
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist

# locale (otherwise perl cries)
sed --in-place 's/^#en_US\.UTF-8/en_US\.UTF-8/' /etc/locale.gen # uncomment
locale-gen

# default user
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
pacman --sync --needed --noconfirm zsh
useradd -m -G wheel -s /bin/zsh sj
passwd sj
exit
Arch.exe config --default-user sj
```

## yay

```sh
sudo pacman --sync --needed --noconfirm base-devel git
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd .. && rm -rf yay-bin
yay --noconfirm
```

## programs

```sh
alias i="yay --sync --needed --noconfirm" # --nodiffmenu --nocleanmenu
i zsh stow zplug starship # prompt
i htop micro man-db man-pages # tuis
i wget moreutils lsd trash-cli fzf bat pfetch pass ffmpeg yt-dlp p7zip # clis
i git gnupg github-cli nodejs-lts-hydrogen pnpm # dev
```

## [wslu](https://wslutiliti.es/wslu/)

```sh
wget https://pkg.wslutiliti.es/public.key
sudo pacman-key --add public.key && rm public.key
sudo pacman-key --lsign-key 2D4C887EB08424F157151C493DD50AA7E055D853
echo -e "\n# https://wslutiliti.es/wslu/\n[wslutilities]\nServer = https://pkg.wslutiliti.es/arch/" | sudo tee -a /etc/pacman.conf
yay -Sy --noconfirm && yay -S --noconfirm wslu
```

## `mkdir -p`

This is done in order to prevent git to track unwanted files and permissions warnings.

```sh
mkdir -p ~/.local/share/gnupg # `gpg: WARNING: unsafe permissions on homedir`
mkdir -p ~/.config/micro      # https://github.com/zyedidia/micro/issues/2004
```

## dotfiles

```sh
gh auth login
git clone https://github.com/sjarbs/archwsl ~/dotfiles
cd ~/dotfiles && stow --adopt .
zplug install
```

## gpg

```sh
git clone https://github.com/sjarbs/keys /tmp/keys
mv ~/.gnupg $GNUPGHOME
gpg --import /tmp/keys/private.asc && rm -rf /tmp/keys
gpg --edit-key <KEY_ID> # tab for autocompletion
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

## vscode

There is a [bug](https://stackoverflow.com/questions/74764599/histfile-in-integrated-terminal-not-the-same-as-normal-terminal) with VSCode's ZSH shell integration that overwrites `$HISTFILE`.

Add this line to your `.vscode/settings.json`

```json
{
  "terminal.integrated.shellIntegration.enabled": false
}
```
