# dotfiles

### Setup on a fresh device
```bash
# Requirements
sudo pacman -Syu git xorg-xsetroot bspwm sxhkd feh picom rofi polybar maim

mv ~/.zshrc ~/.zshrc.bak

git clone --bare git@github.com:Sekhmet/dotfiles.git ~/.local/share/dotfiles
alias dot='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME'
dot checkout

rm ~/.zshrc.bak

source ~/.zshrc
```
