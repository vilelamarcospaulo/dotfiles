return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim",
    },
    config = function()
      local neogit = require('neogit')
      neogit.setup {
      }

      vim.keymap.set("n", "<leader>gs", (function()
        return neogit.open()
      end), { noremap = true })
    end
  },
  { 'akinsho/git-conflict.nvim', version = "*", config = true },

  --  inline gitblame and chunk preview
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 100,
          ignore_whitespace = true,
          virt_text_priority = 100,
        },
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          -- Actions
          map('n', '<leader>hs', gitsigns.stage_hunk)
          map('n', '<leader>hr', gitsigns.reset_hunk)

          map('v', '<leader>hs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          map('v', '<leader>hr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          map('n', '<leader>hS', gitsigns.stage_buffer)
          map('n', '<leader>hR', gitsigns.reset_buffer)
          map('n', '<leader>hp', gitsigns.preview_hunk)
          map('n', '<leader>hi', gitsigns.preview_hunk_inline)

          map('n', '<leader>hb', function() gitsigns.blame_line({ full = true }) end)

          map('n', '<leader>hd', gitsigns.diffthis)

          map('n', '<leader>hD', function()
            gitsigns.diffthis('~')
          end)

          map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
          map('n', '<leader>hq', gitsigns.setqflist)

          -- Toggles
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
          map('n', '<leader>td', gitsigns.toggle_deleted)
          map('n', '<leader>tw', gitsigns.toggle_word_diff)

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
    end
  },

  -- githelper to auto generate links to github
  {
    'ruifm/gitlinker.nvim',
    config = function()
      require 'gitlinker'.setup {}

      vim.api.nvim_set_keymap('n', '<leader>gB',
        '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        { silent = true })
      vim.api.nvim_set_keymap('v', '<leader>gB',
        '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        {})
    end
  },
}
