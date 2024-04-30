# Windows Development Environment Setup Guide **LEGACY**

For Arch Linux, see [archinstall.md](arch/README.md)

## Download and install the following

- [Git](https://git-scm.com/download/win)
- [Python](https://www.python.org/downloads/)
- [Visual Studio Code](https://code.visualstudio.com/download)
- [7zip](https://www.7-zip.org/download.html)
- [Node.js](https://nodejs.org/en/download/)
- [PowerToys](https://learn.microsoft.com/en-us/windows/powertoys/install)
- [GitHub Desktop](https://desktop.github.com/)
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
- [JetBrainsMono Nerd Font](https://www.nerdfonts.com/)
- [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/)
- [Sublime Text](https://www.sublimetext.com/)
- [Docker](https://www.docker.com/)
- [Visual Studio](https://visualstudio.microsoft.com/)
- [Adoptium Temurin](https://adoptium.net/es/temurin/releases/)
- [Windows Terminal](https://github.com/microsoft/terminal) (make default terminal)
- [MSYS2](https://www.msys2.org/) (make sure to add to PATH)

### Git

Setup git credentials:

```bash
git config --global user.email "81328194+secretarybird97@users.noreply.github.com" && git config --global user.name "secretarybird97" && git config --global credential.helper cache --timeout=3600
```

Add .bashrc config to home directory:

```bash
PS1="\W \[\e[32m\]\\$\[\e[m\] "
```

### Python

Make sure to check the box that says "Add Python to PATH" during installation.

### MSYS2

Run the installer and open the MSYS2 UCRT 64-bit terminal, and run the following:

```bash
pacman -Syu
```

Do the same for MSYS2 MSYS terminal:

```bash
pacman -Syu
```

In the MSYS2 UCRT 64-bit terminal, install essential dependancies:

```bash
pacman -S --needed base-devel mingw-w64-ucrt-x86_64-toolchain
```

```bash
pacman -S mingw-w64-ucrt-x86_64-clang mingw-w64-ucrt-x86_64-lldb
```

Open the MSYS2 MinGW 64-bit terminal and check that clang -version is working.

Finally, add MSYS2 bin to PATH.

```text
C:\msys64\ucrt64\bin
```

## WSL Setup

To install WSL, open PowerShell as an administrator and run the following command (refer to [this](https://learn.microsoft.com/en-us/windows/wsl/install)):

```powershell
wsl --install -d Debian
```

Once installed, open a session of WSL and run the following commands:

```bash
sudo apt update && sudo apt upgrade
```

```bash
sudo apt install nala
```

```bash
sudo nala install build-essential clang lldb gdb zsh neofetch black python3-pip wget curl git cmake ripgrep
```

```bash
chsh -s $(which zsh)
```

### ZSH setup

#### Starship

Download and install Starship shell prompt (refer to [this](https://starship.rs/guide/)):

```bash
curl -sS https://starship.rs/install.sh | sh
```

Add the following to the end of `~/.zshrc`:

```bash
eval "$(starship init zsh)"
```

##### Change default preset to use Nerd Font Symbols

```bash
starship preset nerd-font-symbols -o ~/.config/starship.toml

```

#### Oh My Zsh setup & Plugins

Install [Antigen](https://github.com/zsh-users/antigen):

```bash
curl -L git.io/antigen > antigen.zsh
```

Then, copy the [.zshrc](.zshrc) file from this repo to the home directory.

---

To change zsh-autocomplete history limit, add the following to `~/.zshrc` **DEPRECATED**:

```bash
zstyle ':autocomplete:history-search-backward:*' list-lines 256
```

### [Node Version Manager](https://github.com/nvm-sh/nvm)

To install, run:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

```bash
nvm install --lts
```

### GitHub CLI

To install, run:

Debian/Ubuntu:

```bash
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
```

openSUSE/SUSE Linux (zypper):

```bash
sudo zypper addrepo https://cli.github.com/packages/rpm/gh-cli.repo
sudo zypper ref
sudo zypper install gh
```
