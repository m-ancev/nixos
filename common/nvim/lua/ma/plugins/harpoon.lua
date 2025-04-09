return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>H", function() harpoon:list():add() end, { desc = "harpoon current" })
        vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "harpoon list" })

        vim.keymap.set("n", "<leader>j", function() harpoon:list():select(1) end, { desc = "goto 1" })
        vim.keymap.set("n", "<leader>k", function() harpoon:list():select(2) end, { desc = "goto 2" })
        vim.keymap.set("n", "<leader>l", function() harpoon:list():select(3) end, { desc = "goto 3" })
        vim.keymap.set("n", "<leader>;", function() harpoon:list():select(4) end, { desc = "goto 4" })

        -- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "goto previous"})
        -- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "goto next"})
    end
}
