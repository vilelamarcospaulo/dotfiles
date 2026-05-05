return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts.
    -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
    vim.g.no_plugin_maps = true

    -- Or, disable per filetype (add as you like)
    -- vim.g.no_python_maps = true
    -- vim.g.no_ruby_maps = true
    -- vim.g.no_rust_maps = true
    -- vim.g.no_go_maps = true
  end,
  config = function()
    require("nvim-treesitter-textobjects").setup {
      move = {
        set_jumps = true,
      },
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V',  -- linewise
          -- ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = false,
      },
    }

    -- keymaps
    -- selectors
    vim.keymap.set({ "x", "o" }, "am", function()
      require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
    end, { desc = "select around function" })
    vim.keymap.set({ "x", "o" }, "im", function()
      require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
    end, { desc = "select inner function" })
    vim.keymap.set({ "x", "o" }, "ac", function()
      require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
    end, { desc = "select around class" })
    vim.keymap.set({ "x", "o" }, "ic", function()
      require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
    end, { desc = "select inner class" })
    vim.keymap.set({ "x", "o" }, "as", function()
      require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
    end, { desc = "select scope" })
    vim.keymap.set({ "x", "o" }, "aa", function()
      require "nvim-treesitter-textobjects.select".select_textobject("@parameter.outer", "textobjects")
    end, { desc = "select around argument" })
    vim.keymap.set({ "x", "o" }, "ia", function()
      require "nvim-treesitter-textobjects.select".select_textobject("@parameter.inner", "textobjects")
    end, { desc = "select inner argument" })

    -- swaps
    vim.keymap.set("n", "<leader>a", function()
      require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
    end, { desc = "swap next argument" })
    vim.keymap.set("n", "<leader>A", function()
      require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
    end, { desc = "swap prev argument" })

    -- navigation
    vim.keymap.set({ "n", "x", "o" }, "gm", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    end, { desc = "next function" })
    vim.keymap.set({ "n", "x", "o" }, "gM", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
    end, { desc = "prev function" })

    vim.keymap.set({ "n", "x", "o" }, "gc", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
    end, { desc = "next class" })
    vim.keymap.set({ "n", "x", "o" }, "gC", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
    end, { desc = "prev class" })

    vim.keymap.set({ "n", "x", "o" }, "ga", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.outer", "textobjects")
    end, { desc = "next argument" })
    vim.keymap.set({ "n", "x", "o" }, "gA", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.outer", "textobjects")
    end, { desc = "prev argument" })

    vim.keymap.set({ "n", "x", "o" }, "gl", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@assignment.lhs", "textobjects")
    end, { desc = "next assignment" })
    vim.keymap.set({ "n", "x", "o" }, "gL", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@assignment.lhs", "textobjects")
    end, { desc = "prev assignment" })

    vim.keymap.set({ "n", "x", "o" }, "gs", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@block.outer", "textobjects")
    end, { desc = "next block" })
    vim.keymap.set({ "n", "x", "o" }, "gS", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@block.outer", "textobjects")
    end, { desc = "prev block" })
  end,
}
