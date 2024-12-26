return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    vim.keymap.set("n", "<leader>H", function() harpoon:list():add() end, { desc = "[H]arpoon: add current buffer"})
    vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[H]arpoon: show buffer list"})

    vim.keymap.set("n", "<leader>j", function() harpoon:list():select(1) end, { desc = "[H]arpoon: jump to buffer 1"})
    vim.keymap.set("n", "<leader>k", function() harpoon:list():select(2) end, { desc = "[H]arpoon: jump to buffer 2"})
    vim.keymap.set("n", "<leader>l", function() harpoon:list():select(3) end, { desc = "[H]arpoon: jump to buffer 3"})
    vim.keymap.set("n", "<leader>;", function() harpoon:list():select(4) end, { desc = "[H]arpoon: jump to buffer 4"})

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "[H]arpoon: jump to previous buffer"})

    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "[H]arpoon: jump to next buffer"})
  end
}
