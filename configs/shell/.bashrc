export PATH="$HOME/.local/bin:$PATH"
[[ $- != *i* ]] && return

eval "$(starship init bash)"
eval "$(mise activate bash)"

alias ls='eza --icons --group-directories-first --color=auto'
alias ll='eza -lah --icons'
alias lt='eza --tree --level=2 --icons'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
