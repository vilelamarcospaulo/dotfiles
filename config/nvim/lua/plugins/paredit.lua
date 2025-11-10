return {
  "julienvincent/nvim-paredit",
  ft = { "clojure", "fennel", "scheme" }, -- Load only for Lisp languages
  dependencies = {
    "julienvincent/nvim-paredit-fennel",  -- Optional: for Fennel support
  },
  config = function()
    local paredit = require("nvim-paredit")

    paredit.setup({
      -- Use treesitter for better Clojure understanding
      use_default_keys = true,

      -- Automatically insert closing delimiters
      filetypes = { "clojure", "fennel", "scheme" },

      -- Cursor behavior when slurping/barfing
      cursor_behaviour = "auto", -- or "follow" or "remain"

      -- Enable pairwise dragging for maps {:a 1 :b 2}
      dragging = {
        auto_drag_pairs = true,
      },

      -- Enable auto-indentation after slurp/barf
      indent = {
        enabled = true,
        indentor = require("nvim-paredit.indentation.native").indentor,
      },

      -- Keybindings - using localleader (;) for Clojure operations
      keys = {
        -- Slurping & Barfing (core paredit operations)
        [">)"] = { paredit.api.slurp_forwards, "Slurp forwards" },
        ["<)"] = { paredit.api.barf_forwards, "Barf forwards" },

        [">("] = { paredit.api.barf_backwards, "Barf backwards" },
        ["<("] = { paredit.api.slurp_backwards, "Slurp backwards" },

        -- Dragging elements/forms
        [">e"] = { paredit.api.drag_element_forwards, "Drag element right" },
        ["<e"] = { paredit.api.drag_element_backwards, "Drag element left" },

        [">f"] = { paredit.api.drag_form_forwards, "Drag form right" },
        ["<f"] = { paredit.api.drag_form_backwards, "Drag form left" },

        -- Pairwise dragging (for maps)
        [">p"] = { paredit.api.drag_pair_forwards, "Drag pair right" },
        ["<p"] = { paredit.api.drag_pair_backwards, "Drag pair left" },

        -- Raising (replace parent with current form/element)
        ["<localleader>o"] = { paredit.api.raise_form, "Raise form" },
        ["<localleader>O"] = { paredit.api.raise_element, "Raise element" },

        -- Unwrap/Splice
        ["<localleader>@"] = { paredit.unwrap.unwrap_form_under_cursor, "Splice sexp" },

        -- Navigation - Enhanced vim motions for s-expressions
        ["W"] = {
          paredit.api.move_to_next_element_head,
          "Next element head",
          repeatable = false,
          mode = { "n", "x", "o", "v" },
        },
        ["E"] = {
          paredit.api.move_to_next_element_tail,
          "Next element tail",
          repeatable = false,
          mode = { "n", "x", "o", "v" },
        },
        ["B"] = {
          paredit.api.move_to_prev_element_head,
          "Prev element head",
          repeatable = false,
          mode = { "n", "x", "o", "v" },
        },
        ["gE"] = {
          paredit.api.move_to_prev_element_tail,
          "Prev element tail",
          repeatable = false,
          mode = { "n", "x", "o", "v" },
        },

        -- Jump to parent/top-level forms
        ["("] = {
          paredit.api.move_to_parent_form_start,
          "Parent form start",
          repeatable = false,
          mode = { "n", "x", "v" },
        },
        [")"] = {
          paredit.api.move_to_parent_form_end,
          "Parent form end",
          repeatable = false,
          mode = { "n", "x", "v" },
        },
        ["<localleader>T"] = {
          paredit.api.move_to_top_level_form_head,
          "Top level form head",
          repeatable = false,
          mode = { "n", "x", "v" },
        },

        -- Text objects for forms and elements
        -- Use with d, y, c, v (e.g., daf = delete around form)
        ["af"] = {
          paredit.api.select_around_form,
          "Around form",
          repeatable = false,
          mode = { "o", "v" },
        },
        ["if"] = {
          paredit.api.select_in_form,
          "In form",
          repeatable = false,
          mode = { "o", "v" },
        },
        ["aF"] = {
          paredit.api.select_around_top_level_form,
          "Around top level form",
          repeatable = false,
          mode = { "o", "v" },
        },
        ["iF"] = {
          paredit.api.select_in_top_level_form,
          "In top level form",
          repeatable = false,
          mode = { "o", "v" },
        },
        ["ae"] = {
          paredit.api.select_element,
          "Around element",
          repeatable = false,
          mode = { "o", "v" },
        },
        ["e"] = {
          paredit.api.select_element,
          "Element",
          repeatable = false,
          mode = { "o", "v" },
        },
        ["ie"] = {
          paredit.api.select_element,
          "Element",
          repeatable = false,
          mode = { "o", "v" },
        },
      },
    })

    -- Wrapping keybindings using mini.surround
    -- Format: saie( = surround-add, inside-element, with (
    vim.keymap.set("n", "<localleader>w", "saie)",
      { desc = "Wrap element in ()", remap = true })

    vim.keymap.set("n", "<localleader>[", "saie]",
      { desc = "Wrap element in []", remap = true })

    vim.keymap.set("n", "<localleader>{", "saie}",
      { desc = "Wrap element in {}", remap = true })

    -- Note: You can also use standard mini.surround:
    --   saie)  - Surround element with ()
    --   saie]  - Surround element with []
    --   saie}  - Surround element with {}
    --   sd)    - Delete surrounding ()
    --   sr)]   - Replace surrounding () with []

    -- Auto-command to apply paredit keybindings only in Lisp buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "clojure", "fennel", "scheme" },
      callback = function()
        vim.opt_local.lisp = true
      end,
    })
  end,
}
