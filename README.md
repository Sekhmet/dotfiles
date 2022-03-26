# dotfiles

### Setup on a fresh device
```bash
# Requirements
sudo pacman -Syu git

mv ~/.zshrc ~/.zshrc.bak

git clone --bare git@github.com:Sekhmet/dotfiles.git ~/.local/share/dotfiles
alias dot='/usr/bin/git --git-dir=~/.local/share/dotfiles --work-tree=$HOME'
dot checkout

rm ~/.zshrc.bak

source ~/.zshrc
```
