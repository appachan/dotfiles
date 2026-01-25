#!/bin/bash
set -euo pipefail

input=$(cat)
hook_event_name=$(echo "$input" | jq -r '.hook_event_name // empty')
notification_type=$(echo "$input" | jq -r '.notification_type // empty')
cwd=$(echo "$input" | jq -r '.cwd // empty')
workspace_name=$(basename "$cwd" 2>/dev/null || echo "Unknown")

# detect environment
if [[ "${TERMINAL_EMULATOR:-}" == *JetBrains* ]]; then
  app_name="Android Studio"
elif [[ "${TERM_PROGRAM:-}" == "vscode" ]] || [[ -n "${VSCODE_IPC_HOOK:-}" ]] || [[ -n "${VSCODE_PID:-}" ]]; then
  app_name="VSCode"
elif [[ "${TERM_PROGRAM:-}" == "tmux" ]] || [[ "${TERM_PROGRAM:-}" == "WezTerm" ]]; then
  app_name="WezTerm"
else
  app_name="Unknown Terminal"
fi

# change notification content based on hook event type
case "$hook_event_name" in
  Notification)
    # show notification only for specific types
    if [[ "$notification_type" == "idle_prompt" ]] || [[ "$notification_type" == "permission_prompt" ]]; then
      osascript -e "display notification \"$workspace_name\" with title \"Claude Code - $app_name\" subtitle \"Waiting for your input\" sound name \"Funk\""
    fi
    ;;
  Stop)
    osascript -e "display notification \"$workspace_name\" with title \"Claude Code - $app_name\" subtitle \"Task completed\" sound name \"Funk\""
    ;;
esac
