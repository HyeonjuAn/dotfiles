export ZSH="$HOME/.oh-my-zsh"

function brew() {
  command brew "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)

source $ZSH/oh-my-zsh.sh

bindkey 'ø' autosuggest-accept
bindkey '√' history-substring-search-up
bindkey '∫' history-substring-search-down

eval "$(starship init zsh)"

alias vim="nvim"
alias pip="pip3"
alias python="python3"
alias ls="ls -la --color=auto"
alias lg="lazygit"

# Mac setup for pomo
alias work="timer 50m && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up!'\
        -sound Crystal"
        
alias rest="timer 10m && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over!'\
        -sound Crystal"

# bun completions
[ -s "/Users/hyeonjuan/.bun/_bun" ] && source "/Users/hyeonjuan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=$PATH:/Users/hyeonjuan/.spicetify
export PATH=$PATH:/Users/hyeonjuan/.composer/vendor/bin
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/tcl-tk/lib"
export CPPFLAGS="-I/usr/local/opt/tcl-tk/include"
export PKG_CONFIG_PATH="/usr/local/opt/tcl-tk/lib/pkgconfig"

# Load Angular CLI autocompletion.
source <(ng completion script)
