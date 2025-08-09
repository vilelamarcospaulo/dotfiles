return {
  'echasnovski/mini.starter',
  version = false,
  config = function()
    local starter = require('mini.starter')

    starter.setup {
      header = 'It ain’t much, but it’s honest work!',
      footer = '[ TIP: To exit vim, just power off your computer.]',

      items = {
        { name = '󰊳  Update Lazy [u]',          action = 'Lazy update',         section = '' },
        { name = '  File Explorer     [SPC e]', action = 'NvimTreeToggle',      section = 'Main' },
        { name = '  Find Files      [SPC f f]', action = 'FzfLua files',        section = 'Main' },
        { name = '  Recent Files    [SPC f r]', action = 'FzfLua oldfiles',     section = 'Main' },
        { name = '  Git             [SPC g s]', action = 'Neogit',              section = 'Main' },
        { name = '  Theme change    [SPC h t]', action = 'FzfLua colorschemes', section = 'Main' },
        starter.sections.recent_files(7, true),
      },
      query_updaters = '',
    }

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniStarterOpened',
      callback = function(args)
        local buf = args.buf
        local function buf_keymap(key, cmd)
          vim.keymap.set('n', key, ('<Cmd>lua %s<CR>'):format(cmd), { buffer = buf, nowait = true, silent = true })
        end
        buf_keymap('<CR>', 'MiniStarter.eval_current_item()')

        vim.keymap.set('n', 'u', '<Cmd>Lazy update<CR>', { buffer = buf, nowait = true, silent = true })
        buf_keymap('j', [[MiniStarter.update_current_item('next')]])
        buf_keymap('k', [[MiniStarter.update_current_item('prev')]])
        buf_keymap('l', [[MiniStarter.update_current_section('next')]])
        buf_keymap('h', [[MiniStarter.update_current_section('prev')]])
      end,
    })
  end
}
