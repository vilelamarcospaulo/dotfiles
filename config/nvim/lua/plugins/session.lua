return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    { "<leader>ls", "<cmd>AutoSession search<CR>",  desc = "Session search" },
    { "<leader>ll", "<cmd>AutoSession restore<CR>", desc = "Session restore" },
  },
  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    auto_restore = false,
    suppressed_dirs = { "~/", "~/Downloads", "/" },
    post_restore_cmds = { "NvimTreeRefresh" },
    -- log_level = 'debug',
  },
}
