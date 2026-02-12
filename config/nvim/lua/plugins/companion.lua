return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "folke/noice.nvim",
    },
    config = function()
      require("plugins.codecompanion.notification"):init()
      require("codecompanion").setup({
        strategies = {
          chat = { adapter = "litellm" },
          inline = { adapter = "litellm" },
          cmd = { adapter = "litellm" },
        },

        adapters = {
          http = {
            litellm = function()
              return require("codecompanion.adapters").extend(
                "openai_compatible",
                {
                  env = {
                    url = "https://ist-prod-litellm.nullmplatform.com",
                    api_key = "LITELLM_API_KEY",
                  },
                  schema = {
                    model = {
                      default = "anthropic/claude-opus-4-6", -- change to what your proxy supports
                    },
                  },
                }
              )
            end,
          },
        },

      })

      vim.keymap.set({ "n" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
      vim.keymap.set({ "v" }, "<leader>aa", ":'<,'>CodeCompanionChat ", { noremap = true, silent = false })
    end,
  },
}
