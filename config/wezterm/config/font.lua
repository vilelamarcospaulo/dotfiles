local wezterm = require 'wezterm'

return {
  line_height       = 1.3,
  font              = wezterm.font_with_fallback {
    'FiraCode Nerd Font',
    'DejaVu Sans Mono',
  },
  font_size         = 19,
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
}
