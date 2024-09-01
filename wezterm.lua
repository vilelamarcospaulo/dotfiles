local BACKGROUND_TITLE = '#101010'

local wezterm = require 'wezterm'

local act = wezterm.action
local config = wezterm.config_builder()

config.color_scheme = 'Default Dark (base16)'

config.font = wezterm.font 'Iosevka'
config.font_size = 15.0
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- background_opacity
config.window_background_opacity = 0.90
config.macos_window_background_blur = 20

config.audible_bell = "Disabled"
config.enable_tab_bar = true
config.default_cursor_style = 'SteadyUnderline'
-- config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0, }

config.window_frame = {
  active_titlebar_bg = BACKGROUND_TITLE,
  font = require('wezterm').font 'Roboto Mono',
  font_size = 13,
  button_bg = BACKGROUND_TITLE,
}

config.keys = {
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  {
    key = '|',
    mods = 'CMD',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = '\\',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'raw:36',
    mods = 'CMD',
    action = wezterm.action.ToggleFullScreen,
  },
  { key = "LeftArrow",  mods = "OPT", action = wezterm.action { SendString = "\x1bb" } },
  { key = "RightArrow", mods = "OPT", action = wezterm.action { SendString = "\x1bf" } },
  { key = "LeftArrow",  mods = "CMD", action = wezterm.action { SendString = "\x1bOH" } },
  { key = "RightArrow", mods = "CMD", action = wezterm.action { SendString = "\x1bOF" } },
}

for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CMD',
    action = act.ActivateTab(i - 1),
  })
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = act.ActivatePaneByIndex(i - 1),
  })
end


wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, _config, hover, max_width)
    local background = '#202020'
    local foreground = '#808080'
    local title = tab.active_pane.title
    title = '    ' .. title .. '    '

    if tab.is_active then
      background = BACKGROUND_TITLE
      foreground = '#c0c0c0'
    end


    return {
      { Background = { Color = background } },
      { Text = title },
    }
  end
)


return config
