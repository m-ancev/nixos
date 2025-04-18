return {
    enabled = false,
    "akinsho/bufferline.nvim",
    config = function()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                style_preset = {
                    bufferline.style_preset.no_italic,
                    bufferline.style_preset.no_bold,
                },
                indicator = {
                    style = "none",
                },
                show_buffer_close_icons = false,
            },
        })
    end,
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
}
