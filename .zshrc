export ZSH="$HOME/.oh-my-zsh"

function brew() {
  command brew "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)

source $ZSH/oh-my-zsh.sh

bindkey '^ ' autosuggest-accept
bindkey '√' history-substring-search-up
bindkey '∫' history-substring-search-down

eval "$(starship init zsh)"

alias vim="nvim"
alias pip="pip3"
alias python="python3"
alias ls="ls -la --color=auto"
alias lg="lazygit"

# Mac setup for pomo
alias work="timer 25m && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up!'\
        -sound Crystal"
        
alias rest="timer 5m && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over!'\
        -sound Crystal"

# bun completions
[ -s "/Users/hyeonjuan/.bun/_bun" ] && source "/Users/hyeonjuan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
