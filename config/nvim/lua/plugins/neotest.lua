return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- Vitest adapter
    "marilari88/neotest-vitest",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-vitest")({
          -- Filter directories when searching for test files
          filter_dir = function(name, rel_path, root)
            return name ~= "node_modules"
          end,
          -- Vitest command options
          vitestCommand = "npm run test --",
          -- You can also use: "npx vitest" or "yarn vitest"

          -- Enable watch mode by default
          -- is_test_file = function(file_path)
          --   return string.match(file_path, "%.test%.ts$") or
          --          string.match(file_path, "%.test%.tsx$") or
          --          string.match(file_path, "%.spec%.ts$") or
          --          string.match(file_path, "%.spec%.tsx$")
          -- end,
        }),
      },
      discovery = {
        enabled = true,
        concurrent = 1,
      },
      diagnostic = {
        enabled = true,
        severity = vim.diagnostic.severity.ERROR,
      },
      floating = {
        border = "rounded",
        max_height = 0.8,
        max_width = 0.9,
        options = {},
      },
      icons = {
        passed = "✓",
        running = "⟳",
        failed = "✗",
        skipped = "⊘",
        unknown = "?",
        watching = "👁",
      },
      output = {
        enabled = true,
        open_on_run = "short",
      },
      output_panel = {
        enabled = true,
        open = "botright split | resize 15",
      },
      quickfix = {
        enabled = true,
        open = false,
      },
      status = {
        enabled = true,
        signs = true,
        virtual_text = false,
      },
      strategies = {
        integrated = {
          width = 180,
          height = 60,
        },
      },
      summary = {
        enabled = true,
        expand_errors = true,
        follow = true,
        mappings = {
          attach = "a",
          clear_marked = "M",
          clear_target = "T",
          debug = "d",
          debug_marked = "D",
          expand = { "<CR>", "<2-LeftMouse>" },
          expand_all = "e",
          jumpto = "i",
          mark = "m",
          next_failed = "J",
          output = "o",
          prev_failed = "K",
          run = "r",
          run_marked = "R",
          short = "O",
          stop = "u",
          target = "t",
          watch = "w",
        },
      },
    })

    -- Keybindings
    local opts = { noremap = true, silent = true }

    -- Run tests
    vim.keymap.set("n", "<leader>tr", function()
      neotest.run.run()
    end, vim.tbl_extend("force", opts, { desc = "Test: Run nearest" }))

    vim.keymap.set("n", "<leader>tf", function()
      neotest.run.run(vim.fn.expand("%"))
    end, vim.tbl_extend("force", opts, { desc = "Test: Run file" }))

    vim.keymap.set("n", "<leader>ta", function()
      neotest.run.run(vim.fn.getcwd())
    end, vim.tbl_extend("force", opts, { desc = "Test: Run all" }))

    vim.keymap.set("n", "<leader>tl", function()
      neotest.run.run_last()
    end, vim.tbl_extend("force", opts, { desc = "Test: Run last" }))

    vim.keymap.set("n", "<leader>td", function()
      neotest.run.run({ strategy = "dap" })
    end, vim.tbl_extend("force", opts, { desc = "Test: Debug nearest" }))

    -- UI controls
    vim.keymap.set("n", "<leader>ts", function()
      neotest.summary.toggle()
    end, vim.tbl_extend("force", opts, { desc = "Test: Toggle summary" }))

    vim.keymap.set("n", "<leader>to", function()
      neotest.output.open({ enter = true, auto_close = true })
    end, vim.tbl_extend("force", opts, { desc = "Test: Show output" }))

    vim.keymap.set("n", "<leader>tO", function()
      neotest.output_panel.toggle()
    end, vim.tbl_extend("force", opts, { desc = "Test: Toggle output panel" }))

    -- Navigation
    vim.keymap.set("n", "[t", function()
      neotest.jump.prev({ status = "failed" })
    end, vim.tbl_extend("force", opts, { desc = "Test: Jump to prev failed" }))

    vim.keymap.set("n", "]t", function()
      neotest.jump.next({ status = "failed" })
    end, vim.tbl_extend("force", opts, { desc = "Test: Jump to next failed" }))

    -- Stop/Watch
    vim.keymap.set("n", "<leader>tS", function()
      neotest.run.stop()
    end, vim.tbl_extend("force", opts, { desc = "Test: Stop" }))

    vim.keymap.set("n", "<leader>tw", function()
      neotest.watch.toggle()
    end, vim.tbl_extend("force", opts, { desc = "Test: Toggle watch" }))
  end,
}
