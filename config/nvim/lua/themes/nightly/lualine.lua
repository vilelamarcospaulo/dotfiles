local p = require("themes.nightly.palete").dark_colors

local theme = {
  normal = {
    a = { fg = p.foreground, bg = p.cursorline },
    b = { fg = p.foreground, bg = p.cursorline },
    c = { fg = p.foreground, bg = p.background },
  },

  insert = {
    a = { fg = p.comment, bg = p.background },
    b = { fg = p.foreground, bg = p.cursorline },
    c = { fg = p.foreground, bg = p.background },
  },

  visual = {
    a = { fg = p.color5, bg = p.background },
    b = { fg = p.foreground, bg = p.cursorline },
    c = { fg = p.foreground, bg = p.background },
  },

  inactive = {
    a = { bg = p.none, fg = p.color17 },
    b = { bg = p.none, fg = p.color17 },
    c = { bg = p.none, fg = p.color17 },
  },
}

return theme
