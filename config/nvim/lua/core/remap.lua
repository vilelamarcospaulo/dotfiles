vim.g.mapleader = " "
vim.g.maplocalleader = ";"

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "exit terminal mode" })

-- select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "select all" })
vim.keymap.set('n', '<leader>rr', ':%s//g<Left><Left>', { noremap = true, silent = false, desc = "search and replace" })

-- json formatter
vim.keymap.set("n", "<localleader>jf", "<cmd>%!jq .<CR>", { desc = "format json" })

-- Split window
vim.keymap.set("n", "ss", "<cmd>split<CR>", { desc = "split horizontal" })
vim.keymap.set("n", "sv", "<cmd>vsplit<CR>", { desc = "split vertical" })
vim.keymap.set("n", "sq", "<C-w>q", { desc = "close window" })
vim.keymap.set("n", "<C-q>", "<C-w>q", { desc = "close window" })

-- Move window
vim.keymap.set("n", "sh", "<C-w>h", { desc = "move to left window" })
vim.keymap.set("n", "sk", "<C-w>k", { desc = "move to upper window" })
vim.keymap.set("n", "sj", "<C-w>j", { desc = "move to lower window" })
vim.keymap.set("n", "sl", "<C-w>l", { desc = "move to right window" })

-- window resizing
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]], { desc = "increase width" })
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]], { desc = "decrease width" })
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]], { desc = "increase height" })
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]], { desc = "decrease height" })

-- Comment toggle (built-in gc operator, Neovim 0.10+)
vim.keymap.del('v', 'gc')

local comment_fn = require('vim._comment').operator
vim.keymap.set({ 'v' }, 'gcc', comment_fn, { expr = true, desc = 'Toggle comment line' })
vim.keymap.set({ 'n', 'v' }, '<C-/>', 'gcc', { desc = "comment line", remap = true })

-- Save current buffer
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "save buffer" })

-- Tab movement lines
vim.keymap.set('n', '<S-Tab>', '<<', { noremap = true, silent = true, desc = "unindent line" })

vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true, desc = "indent selection" })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true, desc = "unindent selection" })
