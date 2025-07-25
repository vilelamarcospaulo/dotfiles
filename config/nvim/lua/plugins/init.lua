return {
  'kyazdani42/nvim-web-devicons',
  'ryanoasis/vim-devicons',

  'nvim-treesitter/playground',

  'mbbill/undotree',

  'mg979/vim-visual-multi',

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()

      local opts = {}
      vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', opts)
      vim.api.nvim_set_keymap('v', '<C-_>', 'gc', opts)
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
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
    },
    cmd = {
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
  },
}
