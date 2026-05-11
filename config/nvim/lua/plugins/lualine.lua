local theme = require('themes.nightly.lualine')

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'meuter/lualine-so-fancy.nvim',
  },
  config = function()
    ---@diagnostic disable-next-line: different-requires
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = theme,
        section_separators = { '/' },
        component_separators = { left = '', right = ' ' },
        disabled_filetypes = { 'NvimTree', 'NeogitStatus', 'gitcommit' },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          tabline = 100,
          winbar = 100,
        }
      },
      sections = {
        lualine_a = {
          { 'fancy_mode', width = 8 },
        },
        lualine_b = {
          { 'branch' },
          { 'diff' },
        },
        lualine_c = {
          { 'filename', file_status = true, path = 0 }
        },

        lualine_x = {
          { 'fancy_macro' },
          { 'fancy_searchcount' },
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then
                return '[No LSP]'
              end

              return '[' .. clients[1].name .. ']'
            end,
          },
          {
            'diagnostics',
            symbols = {
              error = ' E',
              warn = ' W',
              info = ' i',
              hint = ' H',
            },
          },
          { 'location' },
          { 'fancy_filetype', ts_icon = '' }
        },
        lualine_y = {},
        lualine_z = {}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      winbar = {
        lualine_c = {
          { 'filename', file_status = true, path = 1 }
        },
        lualine_x = {
        },
      },
      inactive_winbar = {
        lualine_c = {
          { 'filename', file_status = true, path = 1 }
        },
      },
      extensions = {}
    }
  end
}
