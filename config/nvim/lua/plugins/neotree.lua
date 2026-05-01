return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  lazy = false,                    -- neo-tree will lazily load itself
  config = function()
    vim.keymap.set("n", "<leader>e", "<CMD>Neotree toggle<cr>")

    require("neo-tree").setup({
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },

      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true,
        window = {
          mappings = {
            ["<bs>"]  = "navigate_up",
            ["."]     = "set_root",
            ["H"]     = "toggle_hidden",
            ["/"]     = "fuzzy_finder",
            ["f"]     = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
          },
        },
      },

      window = {
        mappings = {
          -- Freed: "s" and anything starting with s
          ["s"]             = "none", -- was open_vsplit — conflicts with your ss/sv/sh
          ["S"]             = "none", -- was open_split

          -- Rest of the defaults
          ["<cr>"]          = "open",
          ["<2-LeftMouse>"] = "open",
          ["<esc>"]         = "cancel",
          ["P"]             = { "toggle_preview", config = { use_float = true } },
          ["C"]             = "close_node",
          ["z"]             = "close_all_nodes",
          ["a"]             = { "add", config = { show_path = "none" } },
          ["A"]             = "add_directory",
          ["d"]             = "delete",
          ["r"]             = "rename",
          ["c"]             = "copy_to_clipboard",
          ["x"]             = "cut_to_clipboard",
          ["p"]             = "paste_from_clipboard",
          ["q"]             = "close_window",
          ["R"]             = "refresh",
          ["?"]             = "show_help",
        },
      },
    })
  end
}
