# Debian Installation Guide

_NOTES:_

- Make sure to use LVM (have a @ / subvolume, and @home /home subvolume. 80 GB for root)

## Pre-installation

- Whem setting up encrypted LVM, be careful of selecting "Erase data"

## Post-installation

### Setup Nala for faster downloads (aptitude frontend)

**ONLY** use Nala for fetching faster mirrors. **Don't** use it directly for installing/managing packages!

- Install Nala

```bash
sudo apt install nala
```

- Run nala fetch

```bash
sudo nala fetch
```

### Desktop environment

- Install gnome

```bash
sudo apt install gnome-core && sudo purge ifupdown
```

After, edit /etc/NetworkManager/NetworkManager.conf and set managed=true

### Swap / ZRam

- Enable zram

```bash
sudo apt install systemd-zram-generator
sudo systemctl daemon-reload
sudo systemctl start /dev/zram0
sudo zramctl # check if it's working
```

### /tmp as TMPFS

- Set /tmp as tmpfs

```bash
ln -s /usr/share/systemd/tmp.mount /etc/systemd/system/
```

### vm.max_map_count

- Add `vm.max_map_count=1048576` to EOF `/etc/sysctl.conf`.

- Update sysctl

```bash
sudo sysctl -p
```

### TRIM SSD

- Enable fstrim.timer if system supports it

```bash
sudo systemctl enable fstrim.timer
```

### Timeshift Backups

- Setup timeshift

Minimum of 2 to 5 per week.

### Dependancies

- Install deps

```bash
sudo apt install git build-essential pkg-config libssl-dev cmake clang clangd lldb apt-transport-https fzf unzip libtool ninja-build gettext python3-pip pipx fonts-recommended ttf-mscorefonts-installer fonts-jetbrains-mono libavcodec-extra vlc firewalld firewall-config neofetch curl zsh
```

- cargo

```bash
cargo install eza bat zoxide fd-find ripgrep cargo-update
```

- pnpm

```bash
pnpm add -g typescript ts-node @angular/cli prettier eslint sass less tree-sitter-cli
```

- Install latest Neovim

```bash
git clone https://github.com/neovim/neovim
cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
```

### CryptSetup

- Add another passphrase in case of disk corruption. [Ref.](https://docs.fedoraproject.org/en-US/quick-docs/encrypting-drives-using-LUKS/#_common_post_installation_tasks)

- Add key

```bash
cryptsetup luksAddKey <device>
```

- Make backup (eg. YYYY-MM-DD_luks\_$DEVICE_backup)

```bash
cryptsetup luksHeaderBackup --header-backup-file <file> <device>
```

- Encrypt the backup file with gpg

#### Autologin

- Install keyutils

```bash
sudo apt install keyutils
```

- Add `keyscript=decrypt_keyctl` to /etc/crypttab

- Add `use_authtok` after pam_gnome_keyring.so at the end of `/etc/pam.d/common-password`

- Update initramfs

```bash
sudo update-initramfs -k all -c
```

### [VPN](https://wiki.debian.org/OpenVPN)

- Install OpenVPN protocol

```bash
sudo apt install openvpn network-manager-openvpn-gnome
```

### Firewall

```bashS
sudo apt install firewalld firewall-config
```

```bash
sudo systemctl enable --now firewalld
```

Create a new zone called `debian` and add the following parameters:

- services: `dhcpv6-client mdns samba-client ssh`
- ports: 1025-65535/udp 1025-65535/tcp

Make it default zone (make sure it doesn't conflict with other interfaces)

### [KVM](https://wiki.debian.org/KVM)

```bash
adduser $USER libvirt
virsh --connect=qemu:///system net-autostart default
```
