export EDITOR=nvim
export PS1="%~ $ "

# direnv
eval "$(direnv hook zsh)"

# Make pipx software globally available
export PATH="$PATH:$HOME/.local/bin"

# git autocomplete
autoload -Uz compinit && compinit

# neovim
alias nv="nvim"

alias history="history 1"

# asdf
. "$HOME/.asdf/asdf.sh"
export PATH="/usr/local/opt/libpq/bin:$PATH"

# wezterm
export TERM=wezterm

export PATH="/opt/homebrew/bin:$PATH"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

