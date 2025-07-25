local white      = "#FFFFFF"
local fg         = "#AEAEAE"
local light_bg   = "#202a2e"
local darker_bg  = "#101518"
local limit_bg   = "#2e3d42"
local background = "#141B1E"
local comment_fg = "#FFA700"

return {
  "vilelamarcospaulo/nightly.nvim",
  config = function()
    require("nightly").setup({
      transparent = false,
      styles = {
        comments  = { italic = true },
        functions = { italic = false },
        variables = { italic = false },
        keywords  = { italic = false },
      },
      highlights = {
        ["@comment"]        = { fg = comment_fg },

        MiniStarterFooter   = { fg = "#FB4934" },

        FzfLuaPreviewTitle  = { fg = fg, bg = darker_bg },
        FzfLuaPreviewBorder = { fg = fg, bg = darker_bg },
        FzfLuaFzfScrollbar  = { fg = background, bg = background },
        -- FzfLuaFzfGutter = { fg = background, bg = background },
      },
    })
  end,
}
