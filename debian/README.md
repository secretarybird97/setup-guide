# Debian Installation Guide

_NOTES:_

- Make sure to use LVM (have a @ / subvolume, and @home /home subvolume. 80 GB for root)

## Pre-installation

- Whem setting up encrypted LVM, be careful of selecting "Erase data"

## Post-installation

### Setup Nala (aptitude frontend)

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
sudo nala install gnome-core && sudo purge ifupdown
```

After, edit /etc/NetworkManager/NetworkManager.conf and set managed=true

### Swap / ZRam

- Enable zram

```bash
sudo nala install systemd-zram-generator
sudo systemctl daemon-reload
sudo systemctl start /dev/zram0
sudo zramctl # check if it's working
```

### /tmp as TMPFS

- Set /tmp as tmpfs

```bash
ln -s /usr/share/systemd/tmp.mount /etc/systemd/system/
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
sudo nala install git build-essential cmake clang lldb apt-transport-https fzf unzip python3-pip pipx fonts-recommended ttf-mscorefonts-installer libavcodec-extra vlc firewalld firewall-config neofetch curl
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

### CryptSetup

- Add another passphrase in case of disk corruption. [Ref.](https://docs.fedoraproject.org/en-US/quick-docs/encrypting-drives-using-LUKS/#_common_post_installation_tasks)

- Add key

```bash
cryptsetup luksAddKey <device>
```

- Make backup (eg. YYYY-MM-DD*luks*$DEVICE_backup)

```bash
cryptsetup luksHeaderBackup --header-backup-file <file> <device>
```

- Encrypt the backup file with gpg

#### Autologin

- Install keyutils

```bash
sudo nala install keyutils
```

- Add `keyscript=decrypt_keyctl` to /etc/crypttab

- Add `use_authtok` after pam_gnome_keyring.so at the end of `/etc/pam.d/common-password`

- Update initramfs

```bash
sudo update-initramfs -k all -c
```
