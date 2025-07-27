local wezterm = require 'wezterm'

local config = wezterm.config_builder()

---
config.keys = {}
config.audible_bell = 'Disabled'

-- Font settings
config.font_size = 16
config.line_height = 1.2
config.font = wezterm.font {
  family = 'JetBrains Mono',
  weight = 'Medium',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
}

-- Colors
-- config.color_scheme = 'Mocha (base16)'
-- config.color_scheme = 'Nightfly (Gogh)'
-- config.color_scheme = 'nightfox'
config.color_scheme = 'Gruber (base16)'
-- config.color_scheme = 'Gruvbox Dark (Gogh)'
-- config.color_scheme = 'Gruvbox dark, medium (base16)'
-- config.color_scheme = 'Gruvbox dark, pale (base16)'
config.color_scheme = 'Guezwhoz'


-- tabs
config.hide_tab_bar_if_only_one_tab = true
config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = '#1d1d1d',

    -- The active tab is the one that has focus in the window
    active_tab = {
      bg_color = '#1d1d1d',
      fg_color = '#d9d9d9',

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Bold',

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = 'Double',

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = false,

      strikethrough = false,
    },

    inactive_tab = {
      bg_color = '#333333',
      fg_color = '#d9d9d9',

      strikethrough = true,
    },
  },
}

-- panes
config.keys = {
  { key = '\\', mods = 'CMD',     action = wezterm.action.SplitPane { direction = 'Right' } },
  { key = '\\', mods = 'CMD|ALT', action = wezterm.action.SplitPane { direction = 'Down' } },
  { key = 'w',  mods = 'CMD',     action = wezterm.action.CloseCurrentPane { confirm = false }, },

  -- Pane navigation with vim-style keys (CTRL+h/j/k/l)
  { key = 'h',  mods = 'CTRL',    action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'j',  mods = 'CTRL',    action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k',  mods = 'CTRL',    action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'l',  mods = 'CTRL',    action = wezterm.action.ActivatePaneDirection 'Right' },
}
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.5,
}

-- window container config
config.enable_scroll_bar = true
config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.99
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- clear also viewport (by default only the scrollback)
table.insert(config.keys, { key = 'k', mods = 'CMD', action = wezterm.action.ClearScrollback 'ScrollbackAndViewport' })

return config
