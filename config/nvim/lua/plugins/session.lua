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
    -- log_level = 'debug',
  },
}
