local wezterm = require 'wezterm'

return {
  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.5,
  },
  keys = {
    { key = '\\', mods = 'CMD',     action = wezterm.action.SplitPane { direction = 'Right' } },
    { key = '\\', mods = 'CMD|ALT', action = wezterm.action.SplitPane { direction = 'Down' } },
    { key = 'w',  mods = 'CMD',     action = wezterm.action.CloseCurrentPane { confirm = false }, },

    -- Pane navigation with vim-style keys (CTRL+h/j/k/l)
    { key = 'h',  mods = 'CTRL',    action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'j',  mods = 'CTRL',    action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'k',  mods = 'CTRL',    action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'l',  mods = 'CTRL',    action = wezterm.action.ActivatePaneDirection 'Right' },

    -- Pane resize
    { key = '-',  mods = 'CMD',     action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
    { key = '=',  mods = 'CMD',     action = wezterm.action.AdjustPaneSize { 'Right', 5 } },
    { key = '-',  mods = 'CMD|ALT', action = wezterm.action.AdjustPaneSize { 'Down', 5 } },
    { key = '=',  mods = 'CMD|ALT', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
  }
}
