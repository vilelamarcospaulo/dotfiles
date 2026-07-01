local wezterm = require('wezterm')

-- Tab bar / gap background = the active color scheme's terminal background, so
-- the bar blends with the panes. Keep SCHEME in sync with theme.lua.
local SCHEME = 'Guezwhoz'
local _scheme = wezterm.color.get_builtin_schemes()[SCHEME]
local bar_bg = _scheme and _scheme.background

-- selene: allow(unused_variable) @diagnostic disable-next-line: unused-local
local function create_tab_title(tab, tabs, panes, config, hover, max_width)
  local user_title = tab.active_pane.user_vars.panetitle
  if user_title ~= nil and #user_title > 0 then
    return user_title
  end

  local process = tab.active_pane.foreground_process_name or ''
  process = process:match('([^/\\]+)$') or process

  local cwd = tab.active_pane.current_working_dir
  local path = (cwd and cwd.file_path) or ''
  -- Convert absolute path to relative with ~ for home
  --
  local home = os.getenv("HOME")
  if home and path:sub(1, #home) == home then
    path = "~" .. path:sub(#home + 1)
  end
  -- Normalize to use /
  path = path:gsub("\\", "/")

  -- Agents (e.g. Claude Code) already set a rich OSC title: "<status glyph> <summary>".
  -- Show that verbatim instead of process|cwd so the tab reflects the task + state.
  if process == "claude" then
    local osc = tab.active_pane.title
    if osc and #osc > 0 then
      return osc
    end
  end

  if process == "zsh" then
    return { process = '', path = path }
  else
    return { process = process, path = path }
  end
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = create_tab_title(tab, tabs, panes, config, hover, max_width)

  local THIN_VERTICAL = utf8.char(0x2595) -- ▕ thin vertical bar (process | path separator)

  -- Each tab is a square filled box; active is a muted orange, inactive a dim grey.
  local box_bg, text_fg
  if tab.is_active then
    -- box_bg, text_fg = bar_bg, '#ffba66'
    box_bg, text_fg = bar_bg, '#ffffff'
  else
    box_bg, text_fg = '#3c3836', '#928374'
  end

  -- Label: window index (like tmux) + either an agent/manual title string,
  -- or the process | relative-path pair for shells and editors.
  local label = tostring(tab.tab_index + 1) .. ':'
  if type(title) == 'string' then
    -- agent summary (Claude sets "<status glyph> <summary>") or a manual panetitle
    label = label .. ' ' .. title
  else
    if title.process ~= '' then
      label = label .. ' ' .. title.process
    end
    if title.path ~= '' then
      label = label .. (title.process ~= '' and (' ' .. THIN_VERTICAL .. ' ') or ' ') .. title.path
    end
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
