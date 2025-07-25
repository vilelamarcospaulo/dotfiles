return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      vim.keymap.set('n', '<localleader>db', '<cmd>DapToggleBreakpoint<CR>')
      vim.keymap.set('n', '<localleader>dc', '<cmd>DapContinue<CR>')
    end
  },
  { 'nvim-neotest/nvim-nio' },
  {
    'rcarriga/nvim-dap-ui',
    depends = {
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap',
    },
    config = function()
      require 'dapui'.setup {}
      vim.keymap.set('n', '<localleader>dd', '<cmd>lua require("dapui").toggle()<CR>')
    end
  },
  {
    'theHamsta/nvim-dap-virtual-text',
  },
  {
    'leoluz/nvim-dap-go',
    config = function()
      require('dap-go').setup()
    end,
  }
}
