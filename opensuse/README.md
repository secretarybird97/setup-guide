# Debian Installation Guide

## Pre-installation

- Remove any additional packages using details/patterns
- Enable trusted boot
- Don't make partition for swap if not needed
- Make sure to setup encryption with **LUKS2**. [Reference](https://en.opensuse.org/SDB:Encrypted_root_file_system)
- [SSD Performance](https://en.opensuse.org/SDB:SSD_performance)

## Post-installation

- Change hostname

```bash
sudo hostnamectl set-hostname apollo
```

- Install openSUSE Repo CDN

```bash
sudo zypper in openSUSE-repos-Tumbleweed
```

- Install codecs

```bash
sudo zypper in opi
opi codecs
```

- Enable zram

```bash
sudo zypper in systemd-zram-service
sudo zramswapon
```

- Setup TPM 2.0

```bash
sudo zypper in fde-tools tpm2.0-tools
```

Follow [this](https://en.opensuse.org/SDB:Encrypted_root_file_system)

- Setup Firewall

```bash
sudo zypper in firewall-config
```

Create a new zone called `Tumbleweed` and add the following parameters:

- services: `dhcpv6-client mdns samba-client ssh`
- ports: 1025-65535/udp 1025-65535/tcp

Make it default zone (make sure it doesn't conflict with other interfaces)

- Setup /etc/default/grub

```cfg
GRUB_TIMEOUT=2
GRUB_TIMEOUT_STYLE=hidden
```

- Update grub

```bash
grub2-mkconfig -o /boot/grub2/grub.cfg
```

### Laptop

- Setup TLP

```bash
sudo systemctl enable tlp.service

# Check status
sudo systemctl status tlp.service
```

In /etc/tlp.conf change set the following:

```cfg
TLP_ENABLE=1
RESTORE_DEVICE_STATE_ON_STARTUP=1
```

## Install deps

```bash
sudo zypper in clang lldb fd ripgrep protonvpn chromium vlc neovim vim neofetch bat fzf eza zoxide curl jetbrains-mono-fonts lazygit fetchmsttfonts zsh kitty
```

- Set default shell

```bash
chsh -s $(which zsh)
```

And setup Docker, Visual Studio Code, pipx (black, pylint, isort, poetry), nvm, gh cli, bellsoft jdk, sublime text, flatpak, intellij, rust, flatpak etc

NPM dependancies

```bash
pnpm add -g typescript ts-node prettier eslint sass less neovim tree-sitter-cli
```
