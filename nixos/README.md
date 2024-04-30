# Installation

If first installing NixOS, refer to this [repo](https://github.com/secretarybird97/nixos).
This guide will cover the steps to have a local dev environment ready post-installation for NixOS.

## Deps

- pnpm

```bash
pnpm
pnpm add -g typescript ts-node prettier eslint sass less @angular/cli tree-sitter-cli
```

- python

```bash
pipx install pip
# poetry black isort
```

- rust

```bash
rustup default stable
```

### [Flatpak](https://flathub.org/setup/NixOS)

```bash
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# reboot after
```

### Virt-manager

```bash
sudo virsh net-autostart default
```
