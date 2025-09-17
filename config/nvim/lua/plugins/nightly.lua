local background = "#141B1E"
local foreground = "#AEAEAE"

return {
  "vilelamarcospaulo/nightly.nvim",
  config = function()
    require("nightly").setup({
      transparent = false,
      styles = {
        comments  = { italic = false },
        functions = { italic = false },
        variables = { italic = false },
        keywords  = { italic = false },
      },
      highlights = {
        ["WinBar"] = { bg = background, fg = foreground },
        ["WinBarNC"] = { bg = background, fg = foreground },
      },
    })
  end,
}
