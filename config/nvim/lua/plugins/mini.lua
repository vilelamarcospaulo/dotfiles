return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    require('mini.ai').setup {}
    require('mini.surround').setup {
      mappings = {
        highlight = 'sx', -- Highlight surrounding, avoid conflict with `sh` used on screen management
      }
    }
  end
}
