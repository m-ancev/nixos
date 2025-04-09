return {
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
        require("which-key").setup({
            icons = {
                mappings = false,
                breadcrumb = "", -- This removes the breadcrumb symbol (usually shows the current key combo path)
                separator = "", -- This removes the separator (default is something like "➜")
                group = "", -- This removes the group indicator symbol
            },
        })

        -- Document existing key chains
        require("which-key").add({
            { "<leader>s",  group = "[S]earch" },
            { "<leader>s_", hidden = true },

            { "<leader>T",  group = "[T]heme" },
            { "<leader>T_", hidden = true },

            { "<leader>v",  group = "LSP" },
            { "<leader>v_", hidden = true },
        })
    end,
}
