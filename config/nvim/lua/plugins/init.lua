return {
  'mbbill/undotree',

  {
    "gregorias/coerce.nvim",
    config = function()
      require("coerce").setup()
    end,
  },
}
