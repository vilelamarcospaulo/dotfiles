print("It ain’t much, but it’s honest work!")

require('vilelamarcospaulo.remap')
require('vilelamarcospaulo.lazy')
require('vilelamarcospaulo.clojure')

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.numberwidth = 5
vim.wo.signcolumn = "yes:2"
vim.wo.cursorline = true

vim.o.expandtab = true
vim.o.clipboard = 'unnamedplus'
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.opt.fillchars = { eob = ' ' }
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8

vim.opt.foldlevelstart = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- bugfix for nvim-treesitter folding
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" },
  command = "normal zx",
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = 'filetypedetect',
  pattern = '*.json.base',
  callback = function()
    vim.api.nvim_cmd({
      cmd = 'setf',
      args = { 'json' }
    }, {})
  end
})

vim.cmd 'colorscheme nightly'
-- vim.cmd 'set termguicolors'
