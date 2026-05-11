return {
  'mbbill/undotree',
  'savq/melange-nvim',
  {
    'gregorias/coerce.nvim',
    config = function()
      require('coerce').setup()
    end,
  },
}
