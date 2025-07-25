return { {
  "olimorris/codecompanion.nvim",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "folke/noice.nvim",
  },
  config = function()
    require("plugins.codecompanion.notification"):init()
    require("codecompanion").setup {
      adapters = {
      },
      extensions = {
      },
      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        }
      },
    }

    vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
    vim.keymap.set({ 'n' }, '<leader>aa', ':CodeCompanion #{buffer} ', { noremap = true, silent = false })
    vim.keymap.set({ 'v' }, '<leader>aa', ":'<,'>CodeCompanion<CR>", { noremap = true, silent = false })
  end,
},

  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'codecompanion' }
  }
}
