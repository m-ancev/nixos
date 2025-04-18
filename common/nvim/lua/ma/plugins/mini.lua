-- Collection of various small independent plugins/modules
return {
    "echasnovski/mini.nvim",
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({ n_lines = 500 })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup({})

        -- require("mini.files").setup({
        --     mappings = {
        --         close       = '<ESC>',
        --         go_in       = 'l',
        --         go_in_plus  = '<CR>',
        --         go_out      = 'h',
        --         go_out_plus = 'H',
        --         mark_goto   = "'",
        --         mark_set    = 'm',
        --         reset       = '<BS>',
        --         reveal_cwd  = '@',
        --         show_help   = 'g?',
        --         synchronize = '<leader>w',
        --         trim_left   = '<',
        --         trim_right  = '>',
        --     },
        -- })

        -- Cursor animations, duration [ms]
        -- local animate = require 'mini.animate'
        -- animate.setup {
        --   cursor = {
        --     timing = animate.gen_timing.linear {
        --       duration = 50,
        --       unit = 'total',
        --     },
        --   },
        --   scroll = {
        --     timing = animate.gen_timing.linear {
        --       duration = 50,
        --       unit = 'total',
        --     },
        --   },
        -- }

        -- local statusline = require("mini.statusline")
        -- -- set use_icons to true if you have a Nerd Font
        -- statusline.setup({ use_icons = vim.g.have_nerd_font })
        --
        -- -- You can configure sections in the statusline by overriding their
        -- -- default behavior. For example, here we set the section for
        -- -- cursor location to LINE:COLUMN
        -- ---@diagnostic disable-next-line: duplicate-set-field
        -- statusline.section_location = function()
        -- 	return "%2l:%-2v"
        -- end
    end,
}
