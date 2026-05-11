local M = {}

M.dark_colors = {
  border        = "#232A2D",
  error         = "#E57474",
  string        = "#C8A97C",
  type          = "#E5C76B",
  tag           = "#67B0E8",
  keyword       = "#C47FD5",
  func          = "#6CBFBF",
  variable      = "#B3B9B8",
  overlay       = "#2D3437",
  namespace     = "#EF7E7E",
  match         = "#96D988",
  term_yellow   = "#F4D67A",
  method        = "#71BAF2",
  term_purple   = "#CE89DF",
  builtin       = "#67CBE7",
  fg_bright     = "#BDC3C2",
  bg_panel      = "#0F1416",
  subtle        = "#5A5D61",
  ref_bg        = "#292E42",
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
