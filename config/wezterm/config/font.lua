local wezterm = require 'wezterm'

return {
  font              = wezterm.font_with_fallback {
    'MesloLGL Nerd Font',
    'Hack Nerd Font',
    -- 'FiraCode Nerd Font',
    -- 'Iosevka Nerd Font',
  },
  font_size         = 17,
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
}
