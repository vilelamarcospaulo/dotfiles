#!/bin/sh

set -e
CONFIGS="nvim wezterm atuin aerospace"
CONFIG_DIR="$(pwd)/config"

for name in $CONFIGS; do
  target="$HOME/.config/$name"
  src="$CONFIG_DIR/$name"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "Removing existing $target"
    rm -rf "$target"
  fi
  echo "Symlinking $src -> $target"
  ln -s "$src" "$target"
done

if ! command -v nvim >/dev/null; then
  echo "Installing Neovim..."
  brew install neovim
fi

if ! command -v wezterm >/dev/null; then
  echo "Installing WezTerm..."
  brew install wezterm
fi

if ! command -v atuin >/dev/null; then
  echo "Installing Atuin..."
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi

if ! command -v aerospace >/dev/null; then
  echo "Installing AeroSpace..."
  brew install nikitabobko/tap/aerospace
fi

echo "Setup complete."
