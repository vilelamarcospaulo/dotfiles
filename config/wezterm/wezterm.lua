local Config = require('config')
local wezterm = require('wezterm')

return Config:init()
    :append({
      audible_bell = 'Disabled',
      keys = {
        { key = 'f',          mods = 'CTRL|CMD', action = wezterm.action.ToggleFullScreen },

        -- clear also viewport (by default only the scrollback)
        { key = 'k',          mods = 'CMD',      action = wezterm.action.ClearScrollback 'ScrollbackAndViewport' },

        -- CMD+Right to End
        { key = 'RightArrow', mods = 'CMD',      action = wezterm.action.SendKey { key = 'End' } },

        -- ALT+RightArrow to move right by word
        { key = 'RightArrow', mods = 'ALT',      action = wezterm.action.SendString '\x1bf' },

        -- CMD+Left to Home
        { key = 'LeftArrow',  mods = 'CMD',      action = wezterm.action.SendKey { key = 'Home' } },

        -- ALT+LeftArrow to move left by word
        { key = 'LeftArrow',  mods = 'ALT',      action = wezterm.action.SendString '\x1bb' },

        -- CMD+Backspace to erase entire line (Ctrl+U)
        { key = 'Backspace',  mods = 'CMD',      action = wezterm.action.SendString '\x15', },
      }
    })
    :append(require('config.font'))
    :append(require('config.theme'))
    :append(require('config.pane'))
    :append(require('config.appearance'))
    .options
