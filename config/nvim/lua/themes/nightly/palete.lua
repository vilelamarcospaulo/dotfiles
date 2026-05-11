local M = {}

M.dark_colors = {
  color0        = "#232A2D",
  color1        = "#E57474",
  color2        = "#C8A97C",
  color3        = "#E5C76B",
  color4        = "#67B0E8",
  color5        = "#C47FD5",
  color6        = "#6CBFBF",
  color7        = "#B3B9B8",
  color8        = "#2D3437",
  color9        = "#EF7E7E",
  color10       = "#96D988",
  color11       = "#F4D67A",
  color12       = "#71BAF2",
  color13       = "#CE89DF",
  color14       = "#67CBE7",
  color15       = "#BDC3C2",
  color16       = "#0F1416",
  color17       = "#5A5D61",
  color18       = "#292E42",
  comment       = "#FFA700",
  comment_muted = "#8b949e",
  black         = "#000000",
  light_bg      = "#202a2e",
  background    = "#101114",
  darker_bg     = "#0c0e10",
  foreground    = "#AEAEAE",
  foreground_hl = "#FFFFFF",
  cursorline    = "#242e32",
  none          = "NONE",
}

-- function get_hl(name)
--   local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
--   if not ok then
--     return
--   end
--   for _, key in pairs({ "foreground", "background", "special" }) do
--     if hl[key] then
--       hl[key] = string.format("#%06x", hl[key])
--     end
--   end
--   return hl
-- end
--
-- local normal = get_hl("Normal")
-- for key, value in pairs(normal) do print(key .. value) end

return M
