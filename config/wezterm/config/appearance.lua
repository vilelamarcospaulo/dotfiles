local wezterm = require('wezterm')

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

  if process == "zsh" then
    return { process = '', path = path }
  else
    return { process = process, path = path }
  end
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = create_tab_title(tab, tabs, panes, config, hover, max_width)

  local is_first_tab = tab.tab_index == 0
  local is_last_tab = tab.tab_index == #tabs - 1

  local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
  local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)

  local THIN_VERTICAL = utf8.char(0x2595) -- ▕ Thin vertical bar

  local background = '#121212'
  local foreground = '#606060'

  if tab.is_active then
    background = '#121212'
    foreground = '#FFFFFF'
  end

  local edge_background = "#333333"
  local edge_foreground = background

  local tab_title = {}
  if not is_first_tab then
    table.insert(tab_title, { Attribute = { Intensity = "Bold" } })
    table.insert(tab_title, { Background = { Color = edge_background } })
    table.insert(tab_title, { Foreground = { Color = edge_foreground } })
    table.insert(tab_title, { Text = SOLID_LEFT_ARROW })
  end

  table.insert(tab_title, { Attribute = { Intensity = 'Bold' } })
  table.insert(tab_title, { Background = { Color = background } })
  table.insert(tab_title, { Foreground = { Color = foreground } })
  table.insert(tab_title, { Text = ' ' .. title.process })

  table.insert(tab_title, { Foreground = { Color = foreground } })
  table.insert(tab_title, { Text = (title.process ~= '' and title.path ~= '' and (' ' .. THIN_VERTICAL .. ' ') or '') })
  table.insert(tab_title, { Attribute = { Intensity = 'Normal' } })
  table.insert(tab_title, { Foreground = { Color = foreground } })
  table.insert(tab_title, { Text = title.path .. ' ' })

  if not is_last_tab then
    table.insert(tab_title, { Attribute = { Intensity = "Bold" } })
    table.insert(tab_title, { Background = { Color = edge_background } })
    table.insert(tab_title, { Foreground = { Color = edge_foreground } })
    table.insert(tab_title, { Text = SOLID_RIGHT_ARROW })
  end

  return tab_title
end)

local config = {
  color_scheme = 'Guezwhoz',
  -- show_new_tab_button_in_tab_bar = false,
  -- hide_tab_bar_if_only_one_tab = true,

  use_fancy_tab_bar = false, -- Disable native separators
  tab_max_width = 100,

  enable_scroll_bar = true,
  window_decorations = 'RESIZE',
  window_background_opacity = 0.99,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}


return config
