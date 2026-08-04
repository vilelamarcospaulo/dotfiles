local languages = { "lua", "c", "markdown", "go", "clojure", "ruby", "python", "kotlin" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = languages,
  callback = function()
    vim.treesitter.start()
  end,
})

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  -- main branch has no ensure_installed: install() is the declarative
  -- equivalent, and it no-ops on parsers already present.
  config = function()
    require('nvim-treesitter').install(languages)
  end,
}
