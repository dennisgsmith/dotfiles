export HOMEBREW_NO_ANALYTICS=1

export EDITOR=nvim
export VISUAL=nvim
export PS1="%~ %% "

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/go/bin"

export TERM=wezterm
export GPG_TTY=$(tty)
export HISTSIZE=10000
export OSXSC_LIB=/usr/lib/ssh-keychain.dylib

alias nv="nvim"
alias lzd=lazydocker
alias lzg=lazygit
alias history="history 1"
alias ls=lsd
alias ssh="TERM=xterm ssh"
alias colima="TERM=xterm colima"
alias dps='docker ps --format="table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'

. "$HOME/.asdf/asdf.sh"

eval "$(direnv hook zsh)"

autoload edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

autoload -Uz compinit && compinit
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
