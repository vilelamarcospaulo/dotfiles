return {
  'kyazdani42/nvim-web-devicons',
  'ryanoasis/vim-devicons',

  'mbbill/undotree',

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()

      vim.keymap.set('n', '<C-/>', 'gcc', { desc = "comment line" })
      vim.keymap.set('v', '<C-/>', 'gc', { desc = "comment selection" })
    end
  },

  {
    "gregorias/coerce.nvim",
    config = function()
      require("coerce").setup()
    end,
  },
}
