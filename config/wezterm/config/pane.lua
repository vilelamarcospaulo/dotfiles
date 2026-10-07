local wezterm = require 'wezterm'

local function move_pane_to_tab(tab_index)
  return wezterm.action_callback(function(window, pane)
    local target_tab = window:mux_window():tabs()[tab_index]

    if not target_tab then
      pane:move_to_new_tab()
      pane:activate()
      return
    end

    local current_tab = pane:tab()
    if current_tab and current_tab:tab_id() == target_tab:tab_id() then
      return
    end

    local target_pane = target_tab:active_pane()
    local success, _, stderr = wezterm.run_child_process {
      wezterm.executable_dir .. '/wezterm',
      'cli',
      'split-pane',
      '--pane-id',
      tostring(target_pane:pane_id()),
      '--move-pane-id',
      tostring(pane:pane_id()),
      '--left',
    }

    if success then
      pane:activate()
    else
      window:toast_notification('WezTerm', 'Could not move pane: ' .. stderr, nil, 5000)
    end
  end)
end

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
    split = '#6e574b',     -- soft gruvbox grey; bump to '#fe8019' (orange) for a louder divider
    cursor_bg = '#ffba66', -- active cursor uses your accent so it's easy to spot
    cursor_border = '#ffba66',
    cursor_fg = '#1c1c1c', -- text under the block cursor stays readable
  },
  keys = {
    -- CTRL+\ split right, CTRL+ALT+\ split down (the key you think of as "|")
    { key = '\\',     mods = 'CTRL',       action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '\\',     mods = 'CTRL|ALT',   action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'w',      mods = 'CMD',        action = wezterm.action.CloseCurrentPane { confirm = false }, },

    -- Maximize/restore: zoom the active pane to fill the tab, toggle to restore
    -- the split layout exactly as it was (tmux "prefix z").
    { key = 'Enter',  mods = 'CMD',        action = wezterm.action.TogglePaneZoomState },

    -- Pane navigation with vim-style keys (CTRL+h/j/k/l)
    { key = 'h',      mods = 'CTRL',       action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'j',      mods = 'CTRL',       action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'k',      mods = 'CTRL',       action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'l',      mods = 'CTRL',       action = wezterm.action.ActivatePaneDirection 'Right' },

    -- Pane reorganization: pick a labeled pane to swap with the active one.
    -- Keep focus on the process being moved, matching AeroSpace's move behavior.
    { key = 's',      mods = 'CTRL|SHIFT', action = wezterm.action.PaneSelect { mode = 'SwapWithActiveKeepFocus' } },
    { key = 'j',      mods = 'CTRL|SHIFT', action = wezterm.action.RotatePanes 'CounterClockwise' },
    { key = 'k',      mods = 'CTRL|SHIFT', action = wezterm.action.RotatePanes 'Clockwise' },

    -- Move the active pane into the active pane's left side in the indexed tab.
    { key = 'phys:1', mods = 'CTRL|SHIFT', action = move_pane_to_tab(1) },
    { key = 'phys:2', mods = 'CTRL|SHIFT', action = move_pane_to_tab(2) },
    { key = 'phys:3', mods = 'CTRL|SHIFT', action = move_pane_to_tab(3) },
    { key = 'phys:4', mods = 'CTRL|SHIFT', action = move_pane_to_tab(4) },
    { key = 'phys:5', mods = 'CTRL|SHIFT', action = move_pane_to_tab(5) },
    { key = 'phys:6', mods = 'CTRL|SHIFT', action = move_pane_to_tab(6) },
    { key = 'phys:7', mods = 'CTRL|SHIFT', action = move_pane_to_tab(7) },
    { key = 'phys:8', mods = 'CTRL|SHIFT', action = move_pane_to_tab(8) },
    { key = 'phys:9', mods = 'CTRL|SHIFT', action = move_pane_to_tab(9) },

    -- Pane resize (CTRL for width, +ALT for height) — CMD is now free for font size
    { key = '-',      mods = 'CTRL',       action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
    { key = '=',      mods = 'CTRL',       action = wezterm.action.AdjustPaneSize { 'Right', 5 } },
    { key = '-',      mods = 'CTRL|ALT',   action = wezterm.action.AdjustPaneSize { 'Down', 5 } },
    { key = '=',      mods = 'CTRL|ALT',   action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
  }
}
