local wezterm = require 'wezterm'

return {
  -- No dimming: inactive panes keep the same background/colors as the active one
  -- (1.0/1.0 is the identity transform). Focus is shown via the cursor instead.
  inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 1.0,
  },
  -- Active-pane indicator: only the focused pane blinks a filled cursor;
  -- inactive panes render a hollow, non-blinking one.
  default_cursor_style = 'BlinkingBlock',
  cursor_blink_rate = 500,
  -- Visible divider so panes read as distinct boxes (uniform color; WezTerm
  -- can't color only the active border like tmux does).
  colors = {
    split = '#504945',         -- soft gruvbox grey; bump to '#fe8019' (orange) for a louder divider
    cursor_bg = '#ffba66',     -- active cursor uses your accent so it's easy to spot
    cursor_border = '#ffba66',
    cursor_fg = '#1c1c1c',     -- text under the block cursor stays readable
  },
  keys = {
    { key = '\\', mods = 'CMD',     action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '\\', mods = 'CMD|ALT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
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
