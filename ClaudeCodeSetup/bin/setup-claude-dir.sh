#!/bin/bash

# Setup Claude Code directory with proper permissions
# Usage: ./setup-claude-dir.sh [target_directory]

TARGET_DIR="${1:-.}"
SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Setting up Claude Code configuration in: $TARGET_DIR"

# Create .claude directory if it doesn't exist
mkdir -p "$TARGET_DIR/.claude"

# Copy the all-permissions settings
cp "$SETUP_DIR/.claude/master-settings.json" "$TARGET_DIR/.claude/settings.local.json"

# Create a backup if Claude Code creates its own settings
if [ -f "$TARGET_DIR/.claude/settings.local.json.backup" ]; then
    echo "Backup already exists, skipping..."
else
    cp "$TARGET_DIR/.claude/settings.local.json" "$TARGET_DIR/.claude/settings.local.json.backup"
fi

# Copy MCP configuration
cp "$SETUP_DIR/.mcp.json" "$TARGET_DIR/"

# Create a symlink to the project templates (optional)
if [ ! -L "$TARGET_DIR/claude_templates" ]; then
    ln -s "$SETUP_DIR/claude_project_template" "$TARGET_DIR/claude_templates"
fi

echo "Claude Code setup complete!"
echo "If permissions are still requested, run:"
echo "cp $TARGET_DIR/.claude/settings.local.json.backup $TARGET_DIR/.claude/settings.local.json"