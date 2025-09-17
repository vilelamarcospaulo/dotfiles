local theme = {
  normal = {
    a = { fg = '#AEAEAE', bg = '#242E32' },
    b = { fg = '#AEAEAE', bg = '#242E32' },
    c = { fg = '#AEAEAE', bg = '#101518' },
  },

  insert = {
    a = { fg = "#FFA700", bg = '#101518' },
    b = { fg = '#AEAEAE', bg = '#242E32' },
    c = { fg = '#AEAEAE', bg = '#101518' },
  },

  visual = {
    a = { fg = "#C678DD", bg = '#101518' },
    b = { fg = '#AEAEAE', bg = '#242E32' },
    c = { fg = '#AEAEAE', bg = '#101518' },
  },

  inactive = {
    a = { bg = 'NONE', fg = '#5A5D61' },
    b = { bg = 'NONE', fg = '#5A5D61' },
    c = { bg = 'NONE', fg = '#5A5D61' },
  },
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'meuter/lualine-so-fancy.nvim',
  },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = theme,
        section_separators = { '/' },
        component_separators = { left = '', right = ' ' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
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
                return '[No LSP 󰓨]'
              end

              return '[' .. clients[1].name .. ' 󰓦]'
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
