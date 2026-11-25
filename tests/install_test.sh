#!/usr/bin/env bash
# Usage: install_test.sh <test_name>
# Each test exits 0 on pass, non-zero on fail. Nothing is installed.
set -u
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test_install_script_syntax() {
  [ -f "$ROOT/install.sh" ] || { echo "install.sh missing"; return 1; }
  bash -n "$ROOT/install.sh"
}

test_brewfile_covers_config_tools() {
  [ -f "$ROOT/Brewfile" ] || { echo "Brewfile missing"; return 1; }
  local t missing=""
  for t in neovim alacritty starship neofetch skhd yabai sketchybar tmux lazygit python@3.11 terminal-notifier timer bison flex jq font-jetbrains-mono-nerd-font font-caskaydia-cove-nerd-font font-sketchybar-app-font; do
    grep -Eq "^[[:space:]]*(brew|cask)[[:space:]]+\"([^\"]*/)?${t}\"" "$ROOT/Brewfile" || missing="$missing $t"
  done
  [ -z "$missing" ] || { echo "missing in Brewfile:$missing"; return 1; }
}

# Non-comment lines of install.sh, prefixed with line number
code_lines() { grep -n '' "$ROOT/install.sh" | grep -Ev '^[0-9]+:[[:space:]]*#'; }

test_install_script_installs_oh_my_zsh_and_plugins() {
  [ -f "$ROOT/install.sh" ] || { echo "install.sh missing"; return 1; }
  local p missing=""
  code_lines | grep -Eq 'ohmyzsh/ohmyzsh.*install\.sh|git clone .*ohmyzsh' || missing="$missing oh-my-zsh"
  for p in zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search; do
    code_lines | grep -Eq "(git clone|brew install)[^#]*$p" || missing="$missing $p"
  done
  [ -z "$missing" ] || { echo "install.sh does not install:$missing"; return 1; }
}

test_tool_versions_pins_node_and_python() {
  [ -f "$ROOT/.tool-versions" ] || { echo ".tool-versions missing"; return 1; }
  grep -Eq '^nodejs[[:space:]]+[0-9]+\.[0-9]+\.[0-9]+' "$ROOT/.tool-versions" &&
    grep -Eq '^python[[:space:]]+[0-9]+\.[0-9]+\.[0-9]+' "$ROOT/.tool-versions"
}

test_install_md_documents_sip_before_yabai_addition() {
  [ -f "$ROOT/INSTALL.md" ] || { echo "INSTALL.md missing"; return 1; }
  local sip add
  sip=$(grep -inE 'csrutil disable' "$ROOT/INSTALL.md" | head -1 | cut -d: -f1)
  add=$(grep -inE 'scripting-addition' "$ROOT/INSTALL.md" | head -1 | cut -d: -f1)
  [ -n "$sip" ] && [ -n "$add" ] && [ "$sip" -lt "$add" ]
}

test_install_script_runs_brew_bundle_before_yabai_sa() {
  [ -f "$ROOT/install.sh" ] || { echo "install.sh missing"; return 1; }
  local b
  b=$(grep -n 'brew bundle' "$ROOT/install.sh" | head -1 | cut -d: -f1)
  [ -n "$b" ] || { echo "no brew bundle"; return 1; }
  local y
  y=$(grep -nE 'yabai --(install|load)-sa|scripting-addition' "$ROOT/install.sh" | head -1 | cut -d: -f1)
  [ -n "$y" ] || { echo "install.sh has no yabai scripting-addition step or pointer"; return 1; }
  [ "$b" -lt "$y" ]
}

test_install_script_bootstraps_homebrew_before_brew_bundle() {
  [ -f "$ROOT/install.sh" ] || { echo "install.sh missing"; return 1; }
  local b h
  b=$(code_lines | grep 'brew bundle' | head -1 | cut -d: -f1)
  [ -n "$b" ] || { echo "no brew bundle"; return 1; }
  h=$(code_lines | grep -E 'command -v brew|which brew|Homebrew/install' | head -1 | cut -d: -f1)
  [ -n "$h" ] || { echo "no Homebrew install/check"; return 1; }
  [ "$h" -lt "$b" ]
}

"$@"
