export HOMEBREW_NO_ANALYTICS=1

export EDITOR=nvim
export PS1="%~ $ "

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Make pipx software globally available
export PATH="$PATH:$HOME/.local/bin"

# git autocomplete
autoload -Uz compinit && compinit

# neovim
alias nv="nvim"

alias history="history 1"

# asdf
. "$HOME/.asdf/asdf.sh"

# direnv
eval "$(direnv hook zsh)"

# wezterm
export TERM=wezterm

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

