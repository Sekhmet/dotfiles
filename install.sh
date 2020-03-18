#!/usr/bin/env bash

FZF_DIR=~/.fzf
OH_MY_ZSH_DIR=~/.oh-my-zsh
BASE16_SHELL_DIR=~/.config/base16-shell
VUNDLE_DIR=~/.vim/bundle/Vundle.vim

base() {
	sudo apt install -y zsh curl vim xsel gnupg2 pinentry-curses shellcheck sxhkd maim rofi openbox obmenu obconf feh x11-xserver-utils

	fzf
	oh-my-zsh
	base16
	vundle
}

fzf() {
	if [[ -d "$FZF_DIR" ]]; then
		echo "fzf is already installed"
	else
		echo "Installing fzf"
		git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_DIR"
		~/.fzf/install --key-bindings --completion --no-update-rc
	fi
}

oh-my-zsh() {
	if [[ -d "$OH_MY_ZSH_DIR" ]]; then
		echo "oh-my-zsh is already installed"
	else
		sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	fi
}

base16() {
	if [[ -d "$BASE16_SHELL_DIR" ]]; then
		echo "base16-shell already installed"
	else
		echo "Installing base16-shell"
		git clone https://github.com/chriskempson/base16-shell.git "$BASE16_SHELL_DIR"
	fi
}

vundle() {
	if [[ -d "$VUNDLE_DIR" ]]; then
		echo "Vundle is already installed"
	else
		echo "Installing Vundle and plugins"
		git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_DIR"
		vim -c :PluginInstall
	fi
}

usage() {
	echo "Usage":
	compgen -A function | grep -v ^main$ | xargs -n1 -I {} echo -e "\t{}"
}

main() {
	local cmd=$1

	if [[ -z "$cmd" ]]; then
		usage
		exit 1
	fi

	if [[ $(type -t "$cmd") == 'function' ]]; then
		"$cmd"
	else
		usage
		exit 1
	fi
}

main "$@"
