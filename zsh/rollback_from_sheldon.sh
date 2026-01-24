#!/bin/bash
#
# Rollback script: Sheldon -> Prezto
#
# This script rolls back from sheldon to prezto configuration.
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=========================================="
echo "Sheldon -> Prezto Rollback Script"
echo "=========================================="
echo ""

read -p "Switch back to prezto configuration? (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Rollback cancelled."
    exit 0
fi

echo ""
echo "Rolling back..."

# Switch .zshrc symlink back to .zshrc (prezto version)
if [[ ! -f "$DOTFILES_DIR/.zshrc" ]]; then
    echo "  ❌ Error: .zshrc not found in $DOTFILES_DIR"
    echo "  Cannot rollback without the original .zshrc file."
    exit 1
fi

if [[ -L "$HOME/.zshrc" ]]; then
    unlink "$HOME/.zshrc"
    echo "  ✓ Removed current .zshrc symlink"
fi

ln -s "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
echo "  ✓ Restored ~/.zshrc -> .zshrc (prezto)"

echo ""
echo "=========================================="
echo "✅ Rollback completed!"
echo "=========================================="
echo ""
echo "Please open a new terminal or run: source ~/.zshrc"
echo ""
