# Install order

1. Run `./install.sh` from the repo root (expected at `~/.config`). It does, in order:
   1. Install Homebrew if missing.
   2. `brew bundle` with `Brewfile` (formulae, casks, fonts, taps).
   3. Install oh-my-zsh and the plugins `.zshrc` loads: zsh-autosuggestions, zsh-syntax-highlighting, zsh-history-substring-search.
   4. Language versions: `node` and `python@3.11` come from Homebrew. `.tool-versions` pins nodejs 24.1.0 and python 3.11.13 (read from this machine) for asdf or mise.
   5. Link configs (`~/.zshrc`; the repo lives at `~/.config`).
   6. Start skhd and sketchybar.
2. Disable SIP (needed only for the yabai scripting addition). The steps below are manual.
3. Install and load the yabai scripting addition.

## Disable SIP for yabai

1. Shut down. On Apple Silicon hold the power button until startup options appear, then choose Options. On Intel hold Cmd+R at boot.
2. In Recovery open Utilities > Terminal and run:

   ```
   csrutil disable --with kext --with dtrace --with basesystem
   ```

   On Intel use `csrutil disable --with kext --with dtrace --with nvram --with basesystem`.
3. Reboot to macOS.
4. Apple Silicon only: run `sudo nvram boot-args=-arm64e_preview_abi` and reboot again.

## yabai scripting-addition

After SIP is disabled and you are back in macOS:

```
sudo yabai --install-sa
sudo yabai --load-sa
yabai --start-service
```

`yabairc` runs `sudo yabai --load-sa` at startup. To avoid a password prompt, add a sudoers entry with `sudo visudo -f /private/etc/sudoers.d/yabai`:

```
<user> ALL=(root) NOPASSWD: sha256:<hash of yabai binary> /opt/homebrew/bin/yabai --load-sa
```

Rerun `--install-sa` and update the hash after every yabai upgrade.

## Permissions

Grant Accessibility to yabai, skhd and sketchybar in System Settings > Privacy & Security. Grant Screen Recording to yabai.
