#!/bin/bash
#
# Migration script: Prezto -> Sheldon
#
# This script migrates from zprezto to sheldon-based configuration.
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=========================================="
echo "Prezto -> Sheldon Migration Script"
echo "=========================================="
echo ""
echo "Dotfiles directory: $DOTFILES_DIR"
echo ""

# Check if sheldon is installed
if ! command -v sheldon &> /dev/null; then
    echo "❌ Error: sheldon is not installed"
    echo "Please run: brew install sheldon"
    exit 1
fi

echo "✓ sheldon is installed"
echo ""

# Setup sheldon config
echo "Setting up sheldon configuration..."

if [[ -d "$DOTFILES_DIR/dot_config/sheldon" ]]; then
    mkdir -p "$HOME/.config"
    ln -sfn "$DOTFILES_DIR/dot_config/sheldon" "$HOME/.config/sheldon"
    echo "  ✓ Linked sheldon directory to ~/.config/sheldon"
else
    echo "  ❌ Error: sheldon config directory not found in $DOTFILES_DIR/dot_config/"
    exit 1
fi

# Install sheldon plugins
echo ""
echo "Installing sheldon plugins..."
sheldon lock --update
echo "  ✓ Plugins installed"

# Switch .zshrc symlink to dot_zshrc
echo ""
echo "Switching .zshrc to new configuration..."

if [[ ! -f "$DOTFILES_DIR/dot_zshrc" ]]; then
    echo "  ❌ Error: dot_zshrc not found in $DOTFILES_DIR"
    exit 1
fi

if [[ -L "$HOME/.zshrc" ]]; then
    unlink "$HOME/.zshrc"
fi

ln -s "$DOTFILES_DIR/dot_zshrc" "$HOME/.zshrc"
echo "  ✓ Switched ~/.zshrc -> dot_zshrc"

echo ""
echo "=========================================="
echo "✅ Migration completed successfully!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Open a new terminal or run: source ~/.zshrc"
echo "  2. Test your shell (history, completion, syntax highlighting, etc.)"
echo "  3. If everything works, you can optionally run the cleanup script:"
echo "     $DOTFILES_DIR/zsh/cleanup_prezto.sh"
echo ""
echo "To rollback:"
echo "  Run: $DOTFILES_DIR/zsh/rollback_from_sheldon.sh"
echo ""
