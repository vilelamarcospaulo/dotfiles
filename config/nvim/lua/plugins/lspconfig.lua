return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

    lspconfig.gopls.setup {
      capabilities = capabilities,
      cmd = { 'gopls', 'serve' },
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

    lspconfig.ts_ls.setup {
      capabilities = capabilities,
    }
  end
}
