local wezterm = require 'wezterm'

return {
  line_height       = 1.2,
  font              = wezterm.font_with_fallback {
    { family = 'JetBrains Mono', weight = 'Medium' },
    'FiraCode Nerd Font',
    'DejaVu Sans Mono',
  },
  font_size         = 17,
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
}
