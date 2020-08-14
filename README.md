# dotfiles

### Setup on a fresh device
```bash
# Requirements
sudo apt install git

git clone --bare git@github.com:Sekhmet/dotfiles.git $HOME/.dotfiles
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dot checkout

# Install base tools
./install.sh base

# Initialize new dotfiles
source ~/.zshrc
```
