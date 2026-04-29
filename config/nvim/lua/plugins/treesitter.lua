vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "c", "markdown", "go", "clojure" },
  callback = function()
    vim.treesitter.start()
  end,
})

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate'
}
