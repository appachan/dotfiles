local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font('Cica')
config.font_size = 15.0
config.color_scheme = 'Tomorrow Night'

-- Override specific colors for better visibility
local scheme = wezterm.color.get_builtin_schemes()['Tomorrow Night']
config.colors = {
  ansi = {
    scheme.ansi[1],
    scheme.ansi[2],
    scheme.ansi[3],
    scheme.ansi[4],
    scheme.ansi[5],
    scheme.ansi[6],
    scheme.ansi[7],
    scheme.ansi[8],
  },
  brights = {
    '#707070',  -- bright black (color 8): lighter gray for autosuggestions/borders/UI elements
    scheme.brights[2],
    scheme.brights[3],
    scheme.brights[4],
    scheme.brights[5],
    scheme.brights[6],
    scheme.brights[7],
    scheme.brights[8],
  }
}

config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 10000

-- Use `Option` as `Alt` (needed for word jump, etc.)
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

return config
