return {
  'kyazdani42/nvim-web-devicons',
  'ryanoasis/vim-devicons',

  'mbbill/undotree',

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()

      local opts = {}
      vim.keymap.set('n', '<C-/>', 'gcc', { desc = "comment line" })
      vim.keymap.set('v', '<C-/>', 'gc', { desc = "comment selection" })
    end
  },

  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup {}
      require("telescope").load_extension("textcase")
    end,
    keys = {
      "ga",
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" } },
    },
    cmd = {
      "TextCaseOpenTelescope",
    },
  },
}
