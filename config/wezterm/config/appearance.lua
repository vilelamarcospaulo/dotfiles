local wezterm = require('wezterm')

-- Tab bar / gap background = the active color scheme's terminal background, so
-- the bar blends with the panes. Keep SCHEME in sync with theme.lua.
local SCHEME = 'Guezwhoz'
local _scheme = wezterm.color.get_builtin_schemes()[SCHEME]
local bar_bg = _scheme and _scheme.background

-- Cap the title at this width so a long title can't blow the tab out. Shorter
-- titles keep their natural size; only over-long ones get an ellipsis.
local MAX_TITLE_WIDTH = 100

local function fit_title(title)
  if wezterm.column_width(title) > MAX_TITLE_WIDTH then
    title = wezterm.truncate_right(title, MAX_TITLE_WIDTH - 1) .. '…'
  end
  return title
end

-- Build the tab's label as a single string. Precedence:
--   1. manual panetitle (user_var), if set via `wezterm cli set-tab-title` etc.
--   2. the pane's OSC title.

local function create_tab_title(tab)
  local user_title = tab.active_pane.user_vars.panetitle
  if user_title ~= nil and #user_title > 0 then
    return user_title
  end

  return tab.active_pane.title or ''
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = create_tab_title(tab)

  -- Each tab is a square filled box; active is a muted orange, inactive a dim grey.
  local box_bg, text_fg
  if tab.is_active then
    box_bg, text_fg = bar_bg, '#ffba66'
    -- box_bg, text_fg = bar_bg, '#ffffff'
  else
    box_bg, text_fg = '#3c3836', '#928374'
  end

  -- Label: window index (like tmux) + the title, capped to a max width.
  local label = tostring(tab.tab_index + 1) .. ':'
  if #title > 0 then
    label = label .. ' ' .. fit_title(title)
  end

  local elements = {}

  -- gap before every box except the first, so tabs are spaced without a
  -- stray gap at the left edge
  if tab.tab_index > 0 then
    table.insert(elements, { Background = { Color = bar_bg } })
    table.insert(elements, { Foreground = { Color = bar_bg } })
    table.insert(elements, { Text = '  ' })
  end

  -- square box body
  table.insert(elements, { Attribute = { Intensity = tab.is_active and 'Bold' or 'Normal' } })
  table.insert(elements, { Background = { Color = box_bg } })
  table.insert(elements, { Foreground = { Color = text_fg } })
  table.insert(elements, { Text = ' ' .. label .. ' ' })

  return elements
end)

-- format-tab-title only re-runs when the tab bar is repainted. An *unfocused* tab
-- has no activity of its own to drive that repaint (the active tab does, via its
-- output), so it only refreshes on the status_update_interval tick below — at the
-- 1000ms default an animated OSC title (Claude Code's working spinner) gets sampled
-- once a second and looks frozen while the active tab animates. Setting a status
-- invalidates the tab-bar region, forcing format-tab-title to re-run for all tabs
-- with fresh PaneInformation. The empty right status is just the repaint trigger.
wezterm.on('update-status', function(window, _pane)
  window:set_right_status('')
end)

local config = {
  show_new_tab_button_in_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,

  use_fancy_tab_bar = false, -- Disable native separators
  tab_max_width = 100,

  colors = {
    tab_bar = {
      background = bar_bg, -- empty bar + gaps match the terminal background
    },
  },

  enable_scroll_bar = true,
  window_decorations = 'RESIZE | MACOS_FORCE_SQUARE_CORNERS',
  window_background_opacity = 0.99,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}

return config
