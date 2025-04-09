return {
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
        require("which-key").setup({
            icons = {
                mappings = false,
                breadcrumb = "",
                separator = "",
                group = "",
            },
        })

        -- Document existing key chains
        require("which-key").add({
            { "<leader>s",  group = "search" },
            { "<leader>s_", hidden = true },

            { "<leader>t",  group = "theme" },
            { "<leader>t_", hidden = true },

            { "<leader>v",  group = "lsp" },
            { "<leader>v_", hidden = true },

            { "<leader>vc",  group = "code" },
            { "<leader>vc_", hidden = true },

            { "<leader>vr",  group = "rename" },
            { "<leader>vr_", hidden = true },

            { "<leader>g",  group = "git" },
            { "<leader>g_", hidden = true },
        })
    end,
}
