return {
  "folke/noice.nvim",
  dependencies = {},
  config = function()
    require("noice").setup {
      cmdline = {
        enabled = true,
        view = "cmdline",
        opts = {},
        format = {
          cmdline = { pattern = "^:", icon = " 󰄾", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          input = { view = "cmdline", icon = "" }, -- Used by input()
        },
      },
    }
  end
}
