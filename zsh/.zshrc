export ZSH="$HOME/.oh-my-zsh"

[[ -d /opt/homebrew/share/zsh/site-functions ]] && fpath+=(/opt/homebrew/share/zsh/site-functions)

ZSH_THEME="nord-extended/nord"
DISABLE_UPDATE_PROMPT="true"
plugins=(git symfony6)

source $ZSH/oh-my-zsh.sh

alias vi="nvim"
alias vim="nvim"

if [ -f "$HOME/.zshprofile" ]; then;
    source "$HOME/.zshprofile"
fi

