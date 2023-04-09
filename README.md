# Dotfiles

Managing my personal Dotfiles using [Chezmoi](https://www.chezmoi.io/).

## GPG

For windows I had to `export GPG_TTY=$(tty)` and install pintrny (now in brew script)

## Android

### Termux setup

**
chezmoi.os = "android"
chezmoi.osRelease = ""
**
Some info here

> [https://github.com/mskian/my-termux-setup](https://github.com/mskian/my-termux-setup)

```bash
# Setup repo
termux-change-repo

# View phone files
termux-setup-storage

# Update
pkg update
pkg upgrade
pkg install chezmoi

# Init chezmoi
chezmoi init truxnell
```
