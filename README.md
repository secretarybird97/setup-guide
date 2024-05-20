# Base setup

```bash
git config --global user.email "81328194+secretarybird97@users.noreply.github.com" && git config --global user.name "secretarybird97" && git config --global credential.helper cache --timeout=3600
```

## SSH Keys

### [Git](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

- Generate new pair

```bash
ssh-keygen -t ed25519 -C 81328194+secretarybird97@users.noreply.github.com
```

- Start ssh-agent

```bash
eval "$(ssh-agent -s)"
```

- Add private SSH-Key

```bash
ssh-add ~/.ssh/id_ed25519
```

- Add to Github.com
