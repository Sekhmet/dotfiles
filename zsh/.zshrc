export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export GPG_TTY=$(tty)

export PATH="$PATH:$HOME/.local/bin"

# Node
eval "$(fnm env --use-on-cd --shell zsh)"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PNPM_HOME="/Users/sekhmet/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Go
export PATH="`go env GOPATH`/bin:$PATH"

# Aliases
alias gh_tack="gh pr review -ab \"tACK\""
alias gh_merge="gh pr merge -s"

alias d='yarn dev:interactive'
alias claude="$HOME/.claude/local/claude"

function starkli_env() {
  [ -s "$HOME/.starkli/env" ] && source "/Users/sekhmet/.starkli/env"
}

