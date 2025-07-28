local lsp_format = require 'vilelamarcospaulo.lsp_format_marks'

local function SetupAutoFormat(_supportedActions, bufnr)
  vim.api.nvim_create_autocmd('BufWritePre',
    {
      callback = function()
        lsp_format.format_buffer(bufnr)
      end,
      buffer = bufnr
    })
end

local function SetupAutoOrganizeImports(supportedActions, bufnr)
  if not supportedActions['source.organizeImports'] then
    return
  end

  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    callback = function()
      local context = { source = { organizeImports = true } }
      vim.validate { context = { context, 't', true } }
      local params = vim.lsp.util.make_range_params(0, 'utf-8')
      params.context = context

      local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 100)
      if not result then return end

      result = result[1].result
      if not result then return end

      local edit = result[1].edit
      vim.lsp.util.apply_workspace_edit(edit, 'utf-8')
    end
  })
end

local function LspClientSupportedActions(lsp_client_id)
  local lsp_client = vim.lsp.get_client_by_id(lsp_client_id)
  if not lsp_client then
    return
  end
  local actions = {}
  actions['document.formatting'] = lsp_client.server_capabilities.documentFormattingProvider

  local codeActionProvider = lsp_client and
      lsp_client.server_capabilities and
      lsp_client.server_capabilities.codeActionProvider

  if not codeActionProvider then
    return actions
  end

  local codeActionsKinds = {}
  if type(codeActionProvider) == "table" and
      codeActionProvider.codeActionKinds then
    codeActionsKinds = codeActionProvider.codeActionKinds --[[@as table]]
  elseif type(codeActionProvider) == "boolean" then
    codeActionsKinds = {} -- Empty table, no specific kinds specified
  end

  -- index actions by key
  for _, v in pairs(codeActionsKinds) do
    actions[v] = true
  end

  return actions
end


return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      "L3MON4D3/LuaSnip",
      'hrsh7th/cmp-nvim-lsp',
      'kristijanhusak/vim-dadbod-completion',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup {
        formatting = {
          format = function(entry, vim_item)
            local source = entry.source.name
            local source_name = ({
              nvim_lsp = 'LSP',
              buffer = 'Buffer',
            })[source] or source

            vim_item.menu = '[' .. source_name .. ']'

            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert {
          -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-b>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = "vim-dadbod-completion", max_item_count = 10 },
        },
      }
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')

      lspconfig.clojure_lsp.setup {
        capabilities = capabilities,
        root_dir = function(pattern)
          local util = require("lspconfig.util")
          local fallback = vim.loop.cwd()
          local patterns = { "project.clj", "deps.edn", "build.boot", "shadow-cljs.edn", ".git", "bb.edn" }

          local root = util.root_pattern(patterns)(pattern)
          return (root or fallback)
        end
      }

      lspconfig.dartls.setup {
        capabilities = capabilities,
      }
      lspconfig.gopls.setup {
        cmd = { 'gopls', 'serve' },
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      }

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = {
                [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                [vim.fn.stdpath 'config' .. '/lua'] = true,
              },
            },
          },
        }
      }

      lspconfig.ocamllsp.setup {
        capabilities = capabilities,
      }

      lspconfig.pylsp.setup {
        capabilities = capabilities,
        settings = {
          pylsp = {
            plugins = {
              black = { enabled = true },
              isort = { enabled = true },
            }
          }
        }
      }

      lspconfig.templ.setup {
        capabilities = capabilities,
      }
      vim.filetype.add({ extension = { templ = "templ" } })

      lspconfig.ts_ls.setup {
        capabilities = capabilities
      }

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.diagnostic.config({ virtual_text = false })
      vim.diagnostic.config({ virtual_lines = true })

      vim.keymap.set('n', '<space>d', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end)
      vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(event)
          local fzf = require("fzf-lua")
          local bufnr = event.buf
          local lsp_client_id = event.data.client_id

          -- Enable completion triggered by <c-x><c-o>
          vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = bufnr }

          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gr', fzf.lsp_references, opts)
          vim.keymap.set('n', '<C-p>', fzf.lsp_live_workspace_symbols)

          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', fzf.lsp_implementations, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', fzf.lsp_code_actions, opts)

          local supportedActions = LspClientSupportedActions(lsp_client_id)

          SetupAutoFormat(supportedActions, bufnr)
          SetupAutoOrganizeImports(supportedActions, bufnr)
        end,
      })
    end
  }
}
