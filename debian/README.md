# Debian Installation Guide

_NOTES:_

- Make sure to use LVM (have a @ / subvolume, and @home /home subvolume. 80 GB for root)

## Pre-installation

- Whem setting up encrypted LVM, be careful of selecting "Erase data"

## Post-installation

- Install gnome

```bash
sudo nala install gnome-core && sudo purge ifupdown
```

After, edit /etc/NetworkManager/NetworkManager.conf and set managed=true

- Enable zram

```bash
sudo nala install systemd-zram-generator
sudo systemctl daemon-reload
sudo systemctl start /dev/zram0
sudo zramctl # check if it's working
```

- Enable fstrim.timer if system supports it

```bash
sudo systemctl enable fstrim.timer
```

- Setup timeshift

Minimum of 2 to 5 per week.

- Install deps

```bash
sudo nala install git build-essential cmake clang lldb apt-transport-https fzf unzip python3-pip pipx fonts-recommended ttf-mscorefonts-installer vlc firewalld firewall-config neofetch curl
```

- cargo

```bash
cargo install eza bat zoxide fd-find ripgrep
```

- pnpm

```bash
pnpm add -g typescript ts-node prettier eslint sass less tree-sitter-cli
```

- Install latest Neovim

```bash
git clone https://github.com/neovim/neovim
cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
```
