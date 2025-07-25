return {
  "folke/noice.nvim",
  dependencies = {
    -- "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup {
      cmdline = {
        enabled = true,
        view = "cmdline",
        opts = {},
        ---@type table<string, CmdlineFormat>
        format = {
          cmdline = { pattern = "^:", icon = " 󰄾", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          input = { view = "cmdline", icon = "" }, -- Used by input()
          -- lua = false, -- to disable a format, set to `false`
        },
      },
    }
  end
}
