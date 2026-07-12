---
name: herdr
description: "Read output from or send input to a herdr pane referenced as `herdr pane <id>`. Invoke when the user gives such a reference and asks to read/show/check the pane, or to send input / run a command in it."
---

# herdr pane read / send

When the user gives you a pane reference like `herdr pane w2:p1`, the last token (`w2:p1`) is the pane id. Use the appropriate command below with the Bash tool, then show the user the output.

## Read the pane

Default read:

```bash
herdr pane read <id> --source recent-unwrapped --lines 200
```

Pick a different `--source` when appropriate:

- `visible` — current rendered viewport
- `recent` — recent scrollback as rendered, including soft wraps
- `recent-unwrapped` — recent scrollback with soft wraps joined (best for logs / transcripts, this is the default above)
- `detection` — bottom-buffer snapshot used by agent detection

Add `--format ansi` when terminal colors are evidence.

## Send input to the pane

Pick the command that matches what the user wants sent:

- `herdr pane run <id> "<text>"` — sends `<text>` followed by Enter (submit a command or a prompt)
- `herdr pane send-text <id> "<text>"` — sends `<text>` without Enter (fill a field, keep unsubmitted)
- `herdr pane send-keys <id> <key>` — sends a single key (`enter`, `ctrl+c`, `tab`, …)

Use `pane run` for full commands / prompts. Combine `send-text` + `send-keys enter` only when you need to fill and submit as two steps.

## Pane id shape

Pane ids are opaque strings (examples: `w2:p1`, `w3:pH`). Do not construct them; only use the id the user gave you, or one returned by `herdr pane list` / `herdr pane current --current`.
