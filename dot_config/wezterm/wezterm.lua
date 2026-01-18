local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font('Cica')
config.font_size = 15.0
config.color_scheme = 'Tomorrow Night'

config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 10000

-- Use `Option` as `Alt` (needed for word jump, etc.)
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

return config
