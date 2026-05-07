#!/usr/bin/env bash
# Re-link ~/.config/nvim so it points at dot_config/nvim.
#
# Run this on each machine that previously deployed this dotfiles repo
# while the nvim config lived under .config/nvim. After `git pull`, the
# old path is gone and the existing symlink dangles. Idempotent: safe to
# re-run; does nothing if the link is already correct.
#
# It also runs `git submodule sync && git submodule update --init` for the
# nvim submodule so the path move (.config/nvim -> dot_config/nvim) is
# reflected in the local .git/config.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NEW_TARGET="$DOTFILES/dot_config/nvim"
LINK="$HOME/.config/nvim"

# Refresh the submodule path mapping in this machine's .git/config and
# ensure the submodule is checked out at dot_config/nvim.
(
  cd "$DOTFILES"
  git submodule sync --quiet -- dot_config/nvim
  git submodule update --init -- dot_config/nvim
)

if [[ ! -d "$NEW_TARGET" ]]; then
  echo "error: $NEW_TARGET does not exist even after submodule update" >&2
  exit 1
fi

if [[ -L "$LINK" ]]; then
  current="$(readlink "$LINK")"
  if [[ "$current" == "$NEW_TARGET" ]]; then
    echo "ok: $LINK already points to $NEW_TARGET"
    exit 0
  fi
  echo "==> repointing $LINK"
  echo "    from: $current"
  echo "    to:   $NEW_TARGET"
  unlink "$LINK"
elif [[ -e "$LINK" ]]; then
  echo "error: $LINK exists and is not a symlink; refusing to touch" >&2
  exit 1
fi

mkdir -p "$(dirname "$LINK")"
ln -s "$NEW_TARGET" "$LINK"
echo "ok: $LINK -> $NEW_TARGET"
