local wezterm = require 'wezterm'

return {
  font              = wezterm.font_with_fallback {
    'JetBrains Mono',
    'JetBrains Mono NL', -- fallback
    'MesloLGL Nerd Font',
    -- 'FiraCode Nerd Font',
    -- 'Iosevka Nerd Font',
  },
  font_size         = 19,
  line_height       = 1.0,
  cell_width        = 0.9,
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  -- Font size on CMD (freed now that pane resize moved to CTRL)
  keys = {
    { key = '=', mods = 'CMD', action = wezterm.action.IncreaseFontSize },
    { key = '-', mods = 'CMD', action = wezterm.action.DecreaseFontSize },
    { key = '0', mods = 'CMD', action = wezterm.action.ResetFontSize },
  },
}
