# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Override brew command to trigger SketchyBar updates after brew upgrade/update/outdated
function brew() {
  command brew "$@"

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}

# Plugins for Oh My Zsh
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Custom key bindings for zsh-autosuggestions and history substring search
bindkey '^O' autosuggest-accept

# Initialize Starship prompt
eval "$(starship init zsh)"

# Aliases
alias t="tmux"
alias s="source ~/.zshrc"
alias gpp="g++"
alias gpps="g++ -std=c++20"
alias vim="nvim"
alias s="source ~/.zshrc"
alias cc="claude"
alias c="codex"
alias pip="/opt/homebrew/bin/pip3.11"
# alias python="python3"
# alias python="/opt/homebrew/bin/python3.11"
alias ls="ls -la --color=auto"
alias lg="lazygit"
alias c="claude"
alias cr="claude --agent aidlc-kit:root-agent"

# Mac setup for Pomodoro timer using terminal-notifier
alias work="timer 50m && terminal-notifier -message 'Pomodoro' \
        -title 'Work Timer is up!' \
        -sound Crystal"
alias rest="timer 10m && terminal-notifier -message 'Pomodoro' \
        -title 'Break is over!' \
        -sound Crystal"

alias ai="~/Scripts/ai.sh"

# Bun completions and path setup
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Custom PATH configurations
export PATH=$PATH:/Users/hyeonjuan/.spicetify
export PATH=$PATH:/Users/hyeonjuan/.composer/vendor/bin
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/tcl-tk/lib"
export CPPFLAGS="-I/usr/local/opt/tcl-tk/include"
export PKG_CONFIG_PATH="/usr/local/opt/tcl-tk/lib/pkgconfig"

# Android SDK path setup
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH
export PATH="/opt/homebrew/opt/bison/bin:$PATH"

# Load Angular CLI autocompletion
source <(ng completion script)
export PATH="/opt/homebrew/opt/flex/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/flex/lib"
export CPPFLAGS="-I/opt/homebrew/opt/flex/include"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.kit-release/current/plugin/bin:$PATH"
