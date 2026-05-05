local fzf = require("fzf-lua")

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local buffer = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    -- completion
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup', 'preview' }
      vim.lsp.completion.enable(true, client.id, buffer, { autotrigger = true })
    end

    -- format
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = buffer,
        callback = require('core.lsp.format_marks')
      })
    end

    -- navigation
    local opts = { buffer = buffer }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = buffer, desc = "go to declaration" })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = buffer, desc = "go to definition" })
    vim.keymap.set('n', 'gr', fzf.lsp_references, { buffer = buffer, desc = "list references" })
    vim.keymap.set('n', '<C-p>', fzf.lsp_live_workspace_symbols, { desc = "search workspace symbols" })
    vim.keymap.set('n', 'gi', fzf.lsp_implementations, { buffer = buffer, desc = "list implementations" })

    -- modifiers
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = buffer, desc = "rename symbol" })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', fzf.lsp_code_actions, { buffer = buffer, desc = "code actions" })

    -- diagnostics
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "show diagnostic" })
    vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "prev diagnostic" })
    vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "next diagnostic" })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "diagnostics to loclist" })

    -- info
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = buffer, desc = "hover docs" })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = buffer, desc = "signature help" })
  end,
})
