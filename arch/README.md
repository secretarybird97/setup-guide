# Arch Linux install guide

[WiFi](https://wiki.archlinux.org/title/iwd) setup

---

_NOTES:_

- User generated pacman hooks go in `/etc/pacman.d/hooks/`
- System generated pacman hooks go in `/usr/share/libalpm/hooks/`
- Check arch news before updating
- Periodically clean pacman cache with a pacman [hook](https://wiki.archlinux.org/title/pacman#Cleaning_the_package_cache)
- Use paru -Sca to clean AUR cache
- When using an _SSD_, Start/Enable `fstrim.timer` to periodically trim the SSD
- Use [reflector](https://wiki.archlinux.org/title/Mirrors) to update mirrors list

Make backup of old list

```bash
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
```

Update mirrorlist

```bash
sudo reflector --score 50 --protocol https --country 'United States,' --fastest 5 --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Syyu
```

---

## Additional packages

```bash
fish docker docker-compose neofetch firefox git cmake fzf fd bat ripgrep neovim python-pip python-black clang lldb gdb kitty flatpak ttf-jetbrains-mono-nerd ttf-jetbrains-mono noto-fonts vlc jdk-openjdk qemu-full virt-manager rsync rustup dnsmasq
```

<div class="aside">
   <details>
   <summary>Optional packages</summary>
</div>

```bash
power-profiles-daemon git base-devel
```

</details>

## Post-installation

Change default shell to fish

```bash
chsh -s $(which fish) $USER
```

- Uncomment COLOR and ParallelDownloads in `/etc/pacman.conf`

- Install base-devel and git

```bash
sudo pacman -S --needed base-devel git
```

- Install 2nd kernel

```bash
sudo pacman -S linux-lts linux-lts-headers
```

- Set default kernel to linux: `GRUB_DEFAULT="1>2"`
- Change timeout style to hiden in /etc/default/grub: `GRUB_TIMEOUT_STYLE="hidden"`
- Setup [paru](https://github.com/Morganamilo/paru)
- Make sure cpu ucodes and kernel I/O schedulers are setup correctly

### Setup snapper

- Install dependencies

```bash
sudo pacman -S snapper snap-pac grub-btrfs inotify-tools
```

- Unmount /.snapshots and remove directory

```bash
sudo umount /.snapshots
sudo rmdir /.snapshots
```

- Create subvolume for snapshots in root

```bash
sudo snapper -c root create-config /
```

- Delete duplicate subvolume from archinstall

```bash
sudo btrfs subvolume delete /.snapshots
sudo mkdir /.snapshots
sudo mount -a
```

```bash
sudo btrfs subvolume list / && lsblk
```

```bash
sudo btrfs subvolume set-default XXX /
sudo btrfs subvolume get-default /
```

- Copy [snapper config](snapper_config.txt) to `/etc/snapper/configs/root`

- Enable and start snapper services

```bash
sudo systemctl enable --now snapper.timeline.timer
sudo systemctl enable --now snapper-cleanup.timer
```

- Block indexing of snapshots by adding to /etc/updatedb.conf

---

`PRUNENAMES = ".snapshots"`

---

- Setup pacman hook for _kernel_ updates (see [here](https://wiki.archlinux.org/title/System_backup#Snapshots_and_/boot_partition))

#### Setup [grub-btrfs](https://github.com/Antynea/grub-btrfs)

Install grub-btrfs

```bash
sudo pacman -S grub-btrfs
```

Make sure it's working

```bash
sudo /etc/grub.d/41_snapshots-btrfs
grub-mkconfig -o /boot/grub/grub.cfg
```

Enable systemd service

```bash
sudo systemctl enable --now grub-btrfsd
```

### Setup fish shell

- [Fisher](https://github.com/jorgebucaran/fisher) plugin manager
- [Tide](https://github.com/IlanCosman/tide) prompt
- [nvm.fish](https://github.com/jorgebucaran/nvm.fish)
- [fzf](https://github.com/PatrickF1/fzf.fish)
- [Catppuccin](https://github.com/catppuccin/fish)

Make sure to add cargo and node to path

```bash
set --universal nvm_default_version lts
```

```bash
fisher_add_path $HOME/.cargo/bin
```

- Checkout docker, qemu, libvirtd and the arch wiki for more information. (enable/start services)

## Setup firewalld

```bash
sudo pacman -S firewalld
```

Create a new zone called `ArchLinux` and add the following parameters:

- services: `dhcpv6-client mdns samba-client ssh`
- ports: 1025-65535/udp 1025-65535/tcp

Make it default zone (make sure it doesn't conflict with other interfaces)
