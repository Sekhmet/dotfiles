export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export GPG_TTY=$(tty)

export PATH="$PATH:$HOME/.local/bin"
#
# JavaScript
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Bun
export BUN_INSTALL="$HOME/.bun"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Starkli
. "/Users/sekhmet/.starkli/env"

# Go
export PATH="`go env GOPATH`/bin:$PATH"

# Aliases
alias gh_tack="gh pr review -ab \"tACK\""
alias gh_merge="gh pr merge -s"

alias d='yarn dev:interactive'
alias claude="$HOME/.claude/local/claude"

