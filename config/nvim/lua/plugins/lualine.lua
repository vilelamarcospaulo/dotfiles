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
        theme = 'nightly',
        section_separators = { '' },
        component_separators = { left = '│', right = '│' },
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
        lualine_a = { { 'fancy_mode', width = 10 } },
        lualine_b = { { 'fancy_branch' }, { 'diff' } },
        lualine_c = {
          { 'filename', file_status = true, path = 1 }
        },
        lualine_x = {
          { 'fancy_macro' },
          { 'fancy_searchcount' },
          { 'fancy_location' },
        },
        lualine_y = {
          {
            "diagnostics",
            symbols = {
              error = ' E',
              warn = ' W',
              info = ' i',
              hint = ' H',
            },
          },
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then
                return '[No LSP]'
              end

              return clients[1].name .. '  '
            end,
          },
          { 'fancy_filetype', ts_icon = '' }
        },
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
      tabline = {},
      winbar = {
        lualine_a = {},
        lualine_b = {
          { 'filename', file_status = false, path = 1 }
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = {
          { 'filename', file_status = true, path = 1 }
        },
        lualine_z = {
        },
      },
      extensions = {}
    }
  end
}
