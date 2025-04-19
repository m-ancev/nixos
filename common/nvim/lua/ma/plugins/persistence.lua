return {
  "folke/persistence.nvim",
  event = "BufReadPre",  -- start it when you actually open a buffer
  config = function()
    require("persistence").setup({
      -- store sessions under Neovim’s state directory in a "sessions" subfolder:
      dir = vim.fn.stdpath("state") .. "/sessions/",
      -- which things to store in the session file:
      options = { "buffers", "curdir", "tabpages", "globals" },
      -- (you can add autosave, commands, etc. here)
    })
  end,
}
