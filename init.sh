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

if ! command -v brew >/dev/null; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Each package declares its own deps in a Brewfile next to its config; the
# root Brewfile holds what no single package owns. Adding a package means
# adding its Brewfile, not editing this script.
# --no-upgrade so a setup run never turns into a surprise system upgrade.
find "$DOTFILES" -name Brewfile -not -path '*/.git/*' | while read -r bf; do
  echo "Installing deps from ${bf#"$DOTFILES"/}"
  # </dev/null: brew bundle reads stdin and would otherwise swallow the rest
  # of find's output, silently installing only the first Brewfile.
  brew bundle install --no-upgrade --file="$bf" </dev/null
done

# oh-my-zsh is the one dep brew can't provide.
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  RUNZSH=no KEEP_ZSHRC=yes CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Setup complete. Machine-local overrides: ~/.zshrc.local, ~/.gitconfig.local"
