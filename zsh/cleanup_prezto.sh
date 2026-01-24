#!/bin/bash
#
# Cleanup script: Remove Prezto
#
# This script removes prezto-related files after successful migration to sheldon.
# WARNING: Only run this after confirming the new configuration works!
#

set -e

echo "=========================================="
echo "Prezto Cleanup Script"
echo "=========================================="
echo ""
echo "This will remove:"
echo "  - Prezto runcom symlinks (~/.zlogin, ~/.zlogout, ~/.zpreztorc, ~/.zprofile, ~/.zshenv)"
echo "  - Prezto installation (~/.zprezto)"
echo ""
echo "⚠️  WARNING: Only run this after confirming the new sheldon-based"
echo "   configuration works correctly!"
echo ""

read -p "Continue with cleanup? (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cleanup cancelled."
    exit 0
fi

echo ""
echo "Removing prezto files..."

# Remove prezto runcom links
for file in .zlogin .zlogout .zpreztorc .zprofile .zshenv; do
    if [[ -L "$HOME/$file" ]]; then
        unlink "$HOME/$file"
        echo "  ✓ Removed ~/$file"
    elif [[ -f "$HOME/$file" ]]; then
        echo "  ⚠️  ~/$file exists but is not a symlink (skipping)"
    fi
done

# Remove prezto installation
if [[ -d "$HOME/.zprezto" ]]; then
    rm -rf "$HOME/.zprezto"
    echo "  ✓ Removed ~/.zprezto"
else
    echo "  ℹ️  ~/.zprezto not found (already removed?)"
fi

echo ""
echo "=========================================="
echo "✅ Cleanup completed!"
echo "=========================================="
echo ""
