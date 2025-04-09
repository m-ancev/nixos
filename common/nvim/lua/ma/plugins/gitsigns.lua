-- Adds git related signs to the gutter and utilities for managing changes
return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- navigation
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { desc = "next git change" })

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { desc = "previous git change" })

      -- actions
      -- visual mode
      map("v", "<leader>gs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "stage git hunk" })
      map("v", "<leader>gr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "reset git hunk" })
      -- normal mode
      map("n", "<leader>gS", gitsigns.stage_hunk, { desc = "stage hunk" })
      map("n", "<leader>gR", gitsigns.reset_hunk, { desc = "reset hunk" })
      map("n", "<leader>gs", gitsigns.stage_buffer, { desc = "stage buffer" })
      map("n", "<leader>gr", gitsigns.reset_buffer, { desc = "reset buffer" })
      map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "preview hunk" })
      map("n", "<leader>gb", gitsigns.blame_line, { desc = "blame line" })
      map("n", "<leader>gd", function()
        gitsigns.diffthis("@")
      end, { desc = "diff" })
      -- toggles
      map(
        "n",
        "<leader>gB",
        gitsigns.toggle_current_line_blame,
        { desc = "toggle current line blame" }
      )
    end,
  }
}
