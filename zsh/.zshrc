export ZSH="$HOME/.oh-my-zsh"

[[ -d /opt/homebrew/share/zsh/site-functions ]] && fpath+=(/opt/homebrew/share/zsh/site-functions)

ZSH_THEME="nord-extended/nord"
DISABLE_UPDATE_PROMPT="true"
plugins=(zoxide git symfony6 zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

alias vi="nvim"
alias vim="nvim"
alias fnv='nvim $(fzf -m --preview="bat --color=always {}")'

if [ -f "$HOME/.zshprofile" ]; then;
    source "$HOME/.zshprofile"
fi

