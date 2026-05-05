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
      end), { noremap = true, desc = "open git status" })
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
          end, { desc = "next hunk" })

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end, { desc = "prev hunk" })

          -- Actions
          map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "hunk: stage" })
          map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "hunk: reset" })

          map('v', '<leader>hs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, { desc = "hunk: stage selection" })

          map('v', '<leader>hr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, { desc = "hunk: reset selection" })

          map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "hunk: stage buffer" })
          map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "hunk: reset buffer" })
          map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "hunk: preview" })
          map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = "hunk: preview inline" })

          map('n', '<leader>hb', function() gitsigns.blame_line({ full = true }) end, { desc = "hunk: blame line" })

          map('n', '<leader>hd', gitsigns.diffthis, { desc = "hunk: diff" })

          map('n', '<leader>hD', function()
            gitsigns.diffthis('~')
          end, { desc = "hunk: diff against last commit" })

          map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, { desc = "hunk: all to quickfix" })
          map('n', '<leader>hq', gitsigns.setqflist, { desc = "hunk: to quickfix" })

          -- Toggles
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "toggle line blame" })
          map('n', '<leader>td', gitsigns.toggle_deleted, { desc = "toggle deleted" })
          map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = "toggle word diff" })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "select hunk" })
        end
      }
    end
  },

  -- githelper to auto generate links to github
  {
    'ruifm/gitlinker.nvim',
    config = function()
      require 'gitlinker'.setup {}

      vim.keymap.set('n', '<leader>gB',
        '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        { silent = true, desc = "open line in browser" })
      vim.keymap.set('v', '<leader>gB',
        '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        { desc = "open selection in browser" })
    end
  },
}
