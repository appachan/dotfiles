#!/bin/bash
# Show Claude subscription tier (and org, if any) for ccstatusline.
# `claude auth status` is slow, so cache it and refresh in the background when stale.

CONFIG_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
CACHE="$CONFIG_DIR/.plan_org_cache"
TTL_MIN=60

refresh() {
  local auth tsv
  auth=$(claude auth status 2>/dev/null) || return
  tsv=$(jq -r '[.subscriptionType // "", .orgName // ""] | @tsv' <<<"$auth" 2>/dev/null) || return
  [ -n "$tsv" ] && printf '%s\n' "$tsv" >"$CACHE"
}

if [ ! -f "$CACHE" ]; then
  refresh &
  echo "[Loading...]"
  exit 0
fi

# Stale: refresh in the background while still showing the cached value.
[ -n "$(find "$CACHE" -mmin +"$TTL_MIN" 2>/dev/null)" ] && refresh &

IFS=$'\t' read -r tier org <"$CACHE"
[ -n "$org" ] && echo "[${tier}][${org}]" || echo "[${tier}]"
