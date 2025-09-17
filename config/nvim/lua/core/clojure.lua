vim.api.nvim_create_autocmd('FileType', {
  pattern = 'clojure',
  group = vim.api.nvim_create_augroup('keyword_definition', { clear = true }),
  callback = function()
    vim.opt.iskeyword:remove('-')
    vim.opt.iskeyword:remove('/')
    vim.opt.iskeyword:remove('.')
  end,
})
