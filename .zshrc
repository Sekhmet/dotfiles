export LC_ALL=en_US.UTF-8

export ZSH="/Users/sekhmet/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
export PATH=/usr/local/opt/python/libexec/bin:$PATH

export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

function setup_docker {
	docker-machine start
	eval $(docker-machine env default)
}

precmd() {
	return
	if [[ "$PWD" != "$PREV_PWD" ]]; then
		[[ -f ".nvmrc" ]] || return
		
		grep `nvm version | sed 's/v//'` .nvmrc

		if [[ $? -neq 0 ]]; then
			nvm use
		fi

		PREV_PWD="$PWD"
	fi
}

alias df='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
df config --local status.showUntrackedFiles no
alias dfp='df push origin master'

alias ss='. ~/.zshrc'
alias v='vim'
alias vv='vim ~/.vimrc'
alias vb='vim ~/.zshrc'
alias y='yarn'
alias yy='yarn && yarn deps:install'

