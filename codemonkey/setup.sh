#!/usr/bin/env bash
set -e

INITIATIVE_DIR="$HOME/workspace/initiative"
CLAUDE_COMMANDS_DIR="$HOME/.claude/commands"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "codemonkey setup starting..."

# Create initiative directory
mkdir -p "$INITIATIVE_DIR/templates"

# Copy templates
cp "$SCRIPT_DIR/templates/"*.md "$INITIATIVE_DIR/templates/"

# Create .active file (empty list)
if [ ! -f "$INITIATIVE_DIR/.active" ]; then
  touch "$INITIATIVE_DIR/.active"
fi

# Create INITIATIVES.md index
if [ ! -f "$INITIATIVE_DIR/INITIATIVES.md" ]; then
  cat > "$INITIATIVE_DIR/INITIATIVES.md" << 'EOF'
# Initiatives

| Initiative | Type | Status | Services | Last Updated |
|---|---|---|---|---|
EOF
fi

# Install skills
rm -rf "$CLAUDE_COMMANDS_DIR/codemonkey"
mkdir -p "$CLAUDE_COMMANDS_DIR/codemonkey"
cp "$SCRIPT_DIR/commands/codemonkey.md" "$CLAUDE_COMMANDS_DIR/codemonkey.md"
cp "$SCRIPT_DIR/commands/codemonkey/"*.md "$CLAUDE_COMMANDS_DIR/codemonkey/"

# Init git repo
cd "$INITIATIVE_DIR"
if [ ! -d ".git" ]; then
  git init
  git add .
  git commit -m "chore: codemonkey initialized"
else
  echo "git repo already exists, skipping init"
fi

echo ""
echo "codemonkey ready."
echo "  initiatives: $INITIATIVE_DIR"
echo "  skill:       $CLAUDE_COMMANDS_DIR/codemonkey.md"
echo ""
echo "Start a new initiative with: /codemonkey:start"
