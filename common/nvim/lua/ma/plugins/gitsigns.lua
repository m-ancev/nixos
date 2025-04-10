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

    -- fix background color
    local function update_git_signs_bg()
      local line_number_bg = vim.api.nvim_get_hl_by_name("LineNr", true).background

      local gitsigns_highlights = {
        GitSignsAdd = { bg = line_number_bg },
        GitSignsChange = { bg = line_number_bg },
        GitSignsDelete = { bg = line_number_bg },
        GitSignsAddNr = { bg = line_number_bg },
        GitSignsChangeNr = { bg = line_number_bg },
        GitSignsDeleteNr = { bg = line_number_bg },
        GitSignsAddLn = { bg = line_number_bg },
        GitSignsChangeLn = { bg = line_number_bg },
        GitSignsDeleteLn = { bg = line_number_bg },
        GitSignsAddCul = { bg = line_number_bg },
        GitSignsChangeCul = { bg = line_number_bg },
        GitSignsDeleteCul = { bg = line_number_bg },
        GitSignsAddInline = { bg = line_number_bg },
        GitSignsChangeInline = { bg = line_number_bg },
        GitSignsDeleteInline = { bg = line_number_bg },
        GitSignsAddLnInline = { bg = line_number_bg },
        GitSignsChangeLnInline = { bg = line_number_bg },
        GitSignsDeleteLnInline = { bg = line_number_bg },
        GitSignsAddVirtLnInline = { bg = line_number_bg },
        GitSignsChangeVirtLnInline = { bg = line_number_bg },
        GitSignsDeleteVirtLnInline = { bg = line_number_bg },
      }

      -- iterate through table of highlight groups
      for group, attrs in pairs(gitsigns_highlights) do
        vim.api.nvim_set_hl(0, group, attrs)
      end
    end

    -- autocmd to update on colorscheme change
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = update_git_signs_bg,
    })

    -- initial call
    update_git_signs_bg()

    end,
  }
}
