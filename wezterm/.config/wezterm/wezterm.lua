local wezterm = require 'wezterm'
local config = {}


function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Macchiato"
  else
    return "Catppuccin Latte"
  end
end
-- scheme_for_appearance(wezterm.gui.get_appearance())

config.color_scheme = "Catppuccin Macchiato"
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font 'RyanTerm Nerd Font'
config.font_size = 14

config.keys = {
  {
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.DisableDefaultAssignment,
  },
}


return config