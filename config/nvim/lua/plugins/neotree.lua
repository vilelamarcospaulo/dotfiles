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
        group_empty_dirs = true,
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

      window = {           -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
        -- possible options. These can also be functions that return these options.
        position = "left", -- left, right, top, bottom, float, current
        width = 50,        -- applies to left and right positions
        height = 15,       -- applies to top and bottom positions
        popup = {          -- settings that apply to float position only
          size = {
            height = "80%",
            width = "50%",
          },
          position = "50%", -- 50% means center it
          -- you can also specify border here, if you want a different setting from
          -- the global popup_border_style.
        },
        mappings = {
          -- Freed: "s" and anything starting with s
          ["s"]             = "none", -- was open_vsplit — conflicts with your ss/sv/sh
          ["S"]             = "none", -- was open_split

          -- Tree Navigations
          -- Go to parent (focuses the parent directory node)
          ["P"]             = function(state)
            local node = state.tree:get_node()
            local parent_id = node:get_parent_id()
            if parent_id then
              require("neo-tree.ui.renderer").focus_node(state, parent_id)
            end
          end,

          -- Go to previous sibling (circular)
          ["K"]             = function(state)
            local node = state.tree:get_node()
            local parent_id = node:get_parent_id()
            if not parent_id then return end

            local parent = state.tree:get_node(parent_id)
            local children = parent:get_child_ids()

            for i, id in ipairs(children) do
              if id == node:get_id() then
                local prev = children[i > 1 and i - 1 or #children]
                require("neo-tree.ui.renderer").focus_node(state, prev)
                return
              end
            end
          end,

          -- Go to next sibling (circular)
          ["J"]             = function(state)
            local node = state.tree:get_node()
            local parent_id = node:get_parent_id()
            if not parent_id then return end

            local parent = state.tree:get_node(parent_id)
            local children = parent:get_child_ids()

            for i, id in ipairs(children) do
              if id == node:get_id() then
                local next = children[i < #children and i + 1 or 1]
                require("neo-tree.ui.renderer").focus_node(state, next)
                return
              end
            end
          end,

          -- Rest of the defaults
          ["<cr>"]          = "open",
          ["<2-LeftMouse>"] = "open",
          ["<esc>"]         = "cancel",
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
