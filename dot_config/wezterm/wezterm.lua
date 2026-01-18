local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font('Cica')
config.font_size = 15.0

-- Alacritty default colors (Tomorrow Night based)
config.colors = {
  foreground = '#c5c8c6',
  background = '#1d1f21',

  ansi = {
    '#1d1f21', -- black
    '#cc6666', -- red
    '#b5bd68', -- green
    '#f0c674', -- yellow
    '#81a2be', -- blue
    '#b294bb', -- magenta
    '#8abeb7', -- cyan
    '#c5c8c6', -- white
  },
  brights = {
    '#969896', -- bright black
    '#de935f', -- bright red
    '#b5bd68', -- bright green
    '#f0c674', -- bright yellow
    '#81a2be', -- bright blue
    '#b294bb', -- bright magenta
    '#8abeb7', -- bright cyan
    '#ffffff', -- bright white
  },
}

config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 10000

-- Use `Option` as `Alt` (needed for word jump, etc.)
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

return config
