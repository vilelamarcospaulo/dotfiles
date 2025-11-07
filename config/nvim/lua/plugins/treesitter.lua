return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = function()
    local ts_update = require('nvim-treesitter.install')
        .update({ with_sync = true })
    ts_update()
  end,
  config = function()
    require 'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all"
      ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "templ", "regex", "clojure" },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      
      -- Enhanced text objects
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj
          keymaps = {
            -- Functions
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            
            -- Classes
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            
            -- Conditionals (if/else)
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            
            -- Loops
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            
            -- Parameters/arguments
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            
            -- Comments
            ["a/"] = "@comment.outer",
            ["i/"] = "@comment.inner",
            
            -- Blocks
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
          },
        },
        
        -- Move to next/previous text object
        move = {
          enable = true,
          set_jumps = true, -- Add jumps to jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]A"] = "@parameter.inner",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[A"] = "@parameter.inner",
          },
        },
        
        -- Swap text objects (useful for parameter reordering)
        swap = {
          enable = true,
          swap_next = {
            ["<leader>sn"] = "@parameter.inner",
            ["<leader>sf"] = "@function.outer",
          },
          swap_previous = {
            ["<leader>sp"] = "@parameter.inner",
            ["<leader>sF"] = "@function.outer",
          },
        },
      },
    }
  end
}
