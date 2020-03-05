# dotfiles

### Setup on a fresh device
```bash
# Requirements
sudo apt install git

alias df='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
df checkout

# Install base tools
./install.sh base

# Initialize new dotfiles
source ~/.zshrc
```
