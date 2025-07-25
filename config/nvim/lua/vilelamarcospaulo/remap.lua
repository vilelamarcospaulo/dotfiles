vim.g.mapleader = " "
vim.g.maplocalleader = ";"

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")
vim.keymap.set('n', '<leader>rr', ':%s//g<Left><Left>', { noremap = true, silent = false })

-- json formatter
vim.keymap.set("n", "<localleader>jf", "<cmd>%!jq .<CR>")

-- jump window
vim.keymap.set("n", "<M-1>", "<cmd>wincmd 1 w<CR>")
vim.keymap.set("n", "<M-2>", "<cmd>wincmd 2 w<CR>")
vim.keymap.set("n", "<M-3>", "<cmd>wincmd 3 w<CR>")
vim.keymap.set("n", "<M-4>", "<cmd>wincmd 4 w<CR>")
vim.keymap.set("n", "<M-5>", "<cmd>wincmd 5 w<CR>")
vim.keymap.set("n", "<M-6>", "<cmd>wincmd 6 w<CR>")

-- Split window
vim.keymap.set("n", "ss", "<cmd>split<CR>")
vim.keymap.set("n", "sv", "<cmd>vsplit<CR>")
vim.keymap.set("n", "sq", "<C-w>q")
vim.keymap.set("n", "<C-q>", "<C-w>q")

-- Move window
vim.keymap.set("n", "sh", "<C-w>h")
vim.keymap.set("n", "sk", "<C-w>k")
vim.keymap.set("n", "sj", "<C-w>j")
vim.keymap.set("n", "sl", "<C-w>l")

-- window resizing
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]])   -- make the window biger vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]])   -- make the window smaller vertically
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

-- Save current buffer
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")

-- Tab movement lines
vim.keymap.set('n', '<S-Tab>', '<<', { noremap = true, silent = true })

vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
