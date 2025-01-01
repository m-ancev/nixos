return {
  "karb94/neoscroll.nvim",
  config = function()
    local neoscroll = require('neoscroll')
    -- Neoscroll supports the following easing functions:
    --   "quadratic"
    --   "cubic"
    --   "quartic"
    --   "quintic"
    --   "circular"
    --   "sine"
    neoscroll.setup({
      easing = "sine"
    })
    local keymap = {
      ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 250 }) end,
      ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 250 }) end,

      ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 250 }) end,
      ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 250 }) end,
      ["<PageUp>"] = function() neoscroll.ctrl_b({ duration = 250 }) end,
      ["<PageDown>"] = function() neoscroll.ctrl_f({ duration = 250 }) end,

      ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor = false, duration = 50 }) end,
      ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor = false, duration = 50 }) end,
    }

    local modes = { 'n', 'v', 'x' }

    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end
}
