return {
  'echasnovski/mini.starter',
  version = false,
  config = function()
    local starter = require('mini.starter')
    starter.setup {
      header = 'It ain’t much, but it’s honest work!',
      footer = '[ TIP: To exit vim, just power off your computer.]',

      items = {
        { name = '󰊳  Update Lazy [u]',          action = 'Lazy update',     section = 'Lazy' },
        { name = '  File Explorer     [SPC e]', action = 'NvimTreeToggle',  section = 'Main' },
        { name = '  Find Files      [SPC f f]', action = 'FzfLua files',    section = 'Main' },
        { name = '  Recent Files    [SPC f r]', action = 'FzfLua oldfiles', section = 'Main' },
        { name = '  Git             [SPC g s]', action = 'Neogit',          section = 'Main' },
        { name = '  Theme change    [SPC h t]', action = 'Neogit',          section = 'Main' },
        starter.sections.recent_files(10, true),

      },

      query_updaters = '',
    }
  end
}
