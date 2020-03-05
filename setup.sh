#!/usr/bin/env bash

case $(uname) in
	Darwin)
		echo Installing macOS deps
		brew install wget gpg2 gnupg pinentry-mac
	;;
	Linux)
		echo Installing Linux deps
		sudo apt install -y zsh curl vim xsel gnupg2 pinentry-curses
	;;
esac

OH_MY_ZSH_DIR=~/.oh-my-zsh
BASE16_SHELL_DIR=~/.config/base16-shell
FZF_DIR=~/.fzf
VUNDLE_DIR=~/.vim/bundle/Vundle.vim

if [[ -d "$FZF_DIR" ]]; then
	echo "fzf is already installed"
else
	echo "Installing fzf"
	git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_DIR"
	~/.fzf/install --key-bindings --completion --no-update-rc
fi

if [[ -d "$OH_MY_ZSH_DIR" ]]; then
	echo "oh-my-zsh is already installed"
else
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [[ -d "$BASE16_SHELL_DIR" ]]; then
	echo "base16-shell already installed"
else
	echo "Installing base16-shell"
	git clone https://github.com/chriskempson/base16-shell.git "$BASE16_SHELL_DIR"
fi

if [[ -d "$VUNDLE_DIR" ]]; then
	echo "Vundle is already installed"
else
	echo "Installing Vundle and plugins"
	git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_DIR"
	vim -c :PluginInstall
fi

. ~/.aliases

