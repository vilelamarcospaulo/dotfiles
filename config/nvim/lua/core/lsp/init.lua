local fzf = require("fzf-lua")

vim.lsp.set_log_level("debug")

vim.diagnostic.config({
  virtual_lines = {
    current = true,
  },
  -- virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})


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

      vim.keymap.set('i', '<C-b>', vim.lsp.completion.get)
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
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', fzf.lsp_references, opts)
    vim.keymap.set('n', '<C-p>', fzf.lsp_live_workspace_symbols)
    vim.keymap.set('n', 'gi', fzf.lsp_implementations, opts)

    -- modifiers
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>a', fzf.lsp_code_actions, opts)

    -- diagnostics
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = 0, float = true }) end)
    vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 2, float = true }) end)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

    -- info
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  end,
})
