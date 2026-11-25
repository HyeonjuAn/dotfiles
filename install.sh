#!/usr/bin/env bash
# Install dependencies for these configs. Run from the repo root (~/.config).
# Order: Homebrew, brew bundle, oh-my-zsh + plugins, language versions,
# config links, yabai scripting addition (manual SIP steps: see INSTALL.md).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. Brewfile packages, casks and fonts
brew bundle --file="$ROOT/Brewfile"

# 3. oh-my-zsh and the plugins .zshrc loads
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[ -d "$ZSH_CUSTOM/plugins/zsh-history-substring-search" ] || git clone https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search"

# 4. Language versions: Brewfile provides node and python@3.11.
# .tool-versions records the pins (nodejs, python) for asdf or mise if used.
echo "Language pins in $ROOT/.tool-versions (Homebrew installs node and python@3.11)."

# 5. Link configs. This repo is meant to live at ~/.config.
if [ "$ROOT" != "$HOME/.config" ]; then
  echo "Note: repo is at $ROOT, not ~/.config; link its directories into ~/.config yourself."
fi
if [ -f "$ROOT/.zshrc" ] && [ ! -e "$HOME/.zshrc" ]; then
  ln -s "$ROOT/.zshrc" "$HOME/.zshrc"
fi

# 6. Services (safe without SIP changes)
skhd --start-service || true
brew services start sketchybar || true

# 7. yabai scripting addition. Requires SIP partly disabled first (manual,
# from Recovery mode). See INSTALL.md before running the next lines.
cat <<'EOF'
Final step, manual: follow INSTALL.md to disable SIP, then run:
  sudo yabai --install-sa
  sudo yabai --load-sa
  yabai --start-service
EOF
