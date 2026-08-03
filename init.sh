#!/bin/sh

set -e
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# "<src relative to repo> <target relative to $HOME>"
# ghostty is linked but not installed: wezterm is the primary terminal, the
# ghostty config is just kept ready in case that changes.
LINKS="
config/nvim .config/nvim
config/wezterm .config/wezterm
config/ghostty .config/ghostty
config/atuin .config/atuin
config/aerospace .config/aerospace
config/starship/starship.toml .config/starship.toml
zshrc .zshrc
git/gitconfig .gitconfig
"

echo "$LINKS" | while read -r src rel; do
  [ -n "$src" ] || continue
  target="$HOME/$rel"
  mkdir -p "$(dirname "$target")"
  if [ -L "$target" ]; then
    rm "$target"
  elif [ -e "$target" ]; then
    # real file/dir from before this repo existed: keep it, don't nuke it
    echo "Backing up $target -> $target.bak"
    mv "$target" "$target.bak"
  fi
  echo "Symlinking $DOTFILES/$src -> $target"
  ln -s "$DOTFILES/$src" "$target"
done

# machine-local escapes, sourced/included by the tracked configs above.
# Anything with a machine path or an identity in it belongs here, not in git.
[ -f "$HOME/.zshrc.local" ] || echo "# machine-local zsh config (not tracked)" > "$HOME/.zshrc.local"

[ -f "$HOME/.gitconfig.local" ] || cat > "$HOME/.gitconfig.local" <<'EOF'
# machine-local git config (not tracked)
[user]
	name =
	email =
EOF

if ! command -v nvim >/dev/null; then
  echo "Installing Neovim..."
  brew install neovim
fi

if ! command -v wezterm >/dev/null; then
  # nightly, not stable: the stable cask is years behind and this config
  # is written against nightly.
  echo "Installing WezTerm..."
  brew install --cask wezterm@nightly
fi

if ! command -v starship >/dev/null; then
  echo "Installing Starship..."
  brew install starship
fi

if ! command -v bat >/dev/null; then
  echo "Installing bat..."
  brew install bat
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  RUNZSH=no KEEP_ZSHRC=yes CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if ! command -v atuin >/dev/null; then
  echo "Installing Atuin..."
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi

if ! command -v aerospace >/dev/null; then
  echo "Installing AeroSpace..."
  brew install nikitabobko/tap/aerospace
fi

echo "Setup complete. Machine-local overrides: ~/.zshrc.local, ~/.gitconfig.local"
