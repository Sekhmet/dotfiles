export GPG_TTY=$(tty)
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XDG_STATE_HOME=$HOME/.local/state

export ZSH="$XDG_DATA_HOME"/oh-my-zsh
ZSH_THEME="robbyrussell"
ZSH_COMPDUMP="$XDG_CACHE_HOME"/zsh/zcompdump
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Android
export JAVA_HOME=/opt/android-studio/jre
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_NDK_HOME=$HOME/Android/Sdk/ndk/20.0.5594570
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="$PATH:$HOME/.foundry/bin"

# JavaScript
export NVM_DIR="$XDG_DATA_HOME"/nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:$HOME/.yarn/bin

# Aliases
alias gbr="git branch | grep -v "master" | xargs git branch -D"
alias vim=nvim

# XDG workarounds
# To be removed in 2035
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
export HISTFILE="$XDG_STATE_HOME"/zsh/history

alias dot="/usr/bin/git --git-dir=$XDG_DATA_HOME/dotfiles --work-tree=$HOME"
dot config --local status.showUntrackedFiles no

# Tweaks
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND='rg --files'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
[ -f "/usr/share/fzf/key-bindings.zsh" ] && source /usr/share/fzf/key-bindings.zsh

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

dcd () {
    WORK_DIR=~/Workspace
    dest=$(find "$WORK_DIR" -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | fzf)
    [ "$?" -eq 1 ] && return 0

    cd "$WORK_DIR/$dest"
}

bindkey -s '^o' 'dcd\n'
