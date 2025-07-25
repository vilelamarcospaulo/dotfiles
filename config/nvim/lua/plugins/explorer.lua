local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { link = "Directory" })

  vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
  vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
  vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
  vim.keymap.set("n", "a", api.fs.create, opts("Create File Or Directory"))
  vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
  vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
  vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
  vim.keymap.set("n", "F", api.live_filter.clear, opts("Live Filter: Clear"))
  vim.keymap.set("n", "f", api.live_filter.start, opts("Live Filter: Start"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
  vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  vim.keymap.set("n", "ge", api.fs.copy.basename, opts("Copy Basename"))
  vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Filter: Dotfiles"))
  vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Filter: Git Ignore"))
  vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
  vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
  vim.keymap.set("n", "L", api.node.open.toggle_group_empty, opts("Toggle Group Empty"))
  vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
  vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
  vim.keymap.set("n", "q", api.tree.close, opts("Close"))
  vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
  vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
  vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
  vim.keymap.set("n", "u", api.fs.rename_full, opts("Rename: Full Path"))
  vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Filter: Hidden"))
  vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
  vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
  vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
  vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
end

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
  },
  config = function()
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

    require("nvim-tree").setup({
      on_attach = my_on_attach,
      hijack_cursor = true,
      actions = {
        open_file = {
          quit_on_open = true,
          window_picker = {
            enable = false
          }
        },
      },
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        adaptive_size = true,
        width = 50,
      },
      renderer = {
        add_trailing = true,
        indent_markers = {
          enable = true,
          inline_arrows = false,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        highlight_opened_files = "name",
        group_empty = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = false,
            git = true,
            modified = true,
            hidden = false,
            diagnostics = true,
            bookmarks = true,
          },
        }
      },
      filters = {
        dotfiles = true,
      },
      update_focused_file = {
        enable = true,
        update_root = true
      },
    })
  end,
}
