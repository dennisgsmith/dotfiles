export HOMEBREW_NO_ANALYTICS=1

export EDITOR=nvim
export PS1="%~ %% "

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/go/bin"

export DOCKER_HOST=unix:///$HOME/.colima/docker.sock
export TERM=wezterm
export GPG_TTY=$(tty)

alias nv="nvim"
alias lzd=lazydocker
alias lzg=lazygit
alias history="history 1"
alias ls=lsd
alias ssh="TERM=xterm ssh"
alias dps='docker ps --format="table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'

. "$HOME/.asdf/asdf.sh"

eval "$(direnv hook zsh)"

autoload -Uz compinit && compinit
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
