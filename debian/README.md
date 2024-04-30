# Debian Installation Guide

_NOTES:_

- Make sure to use LVM (have a @ / subvolume, and @home /home subvolume. 80 GB for root)

## Pre-installation

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

- Setup timeshift

Minimum of 2 snapshots per day, and 2 per boot

- Install latest Neovim

```bash
git clone https://github.com/neovim/neovim
cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
```
