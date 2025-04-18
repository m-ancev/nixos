return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        -- dashboard.section.header.val = {
        --   [[                                                     ___]],
        --   [[                                                  ,o88888]],
        --   [[                                               ,o8888888']],
        --   [[                         ,:o:o:oooo.        ,8O88Pd8888"]],
        --   [[                     ,.::.::o:ooooOoOoO. ,oO8O8Pd888'"]],
        --   [[                   ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"]],
        --   [[                  , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"]],
        --   [[                 , ..:.::o:ooOoOO8O888O8O,COCOO"]],
        --   [[                , . ..:.::o:ooOoOOOO8OOOOCOCO"]],
        --   [[                 . ..:.::o:ooOoOoOO8O8OCCCC"o]],
        --   [[                    . ..:.::o:ooooOoCoCCC"o:o]],
        --   [[                    . ..:.::o:o:,cooooCo"oo:o:]],
        --   [[                 `   . . ..:.:cocoooo"'o:o:::']],
        --   [[                 .`   . ..::ccccoc"'o:o:o:::']],
        --   [[                :.:.    ,c:cccc"':.:.:.:.:.']],
        --   [[              ..:.:"'`::::c:"'..:.:.:.:.:.']],
        --   [[            ...:.'.:.::::"'    . . . . .']],
        --   [[           .. . ....:."' `   .  . . '']],
        --   [[         . . . ...."']],
        --   [[         .. . ."']],
        --   [[        .]],
        -- }
        dashboard.section.header.val = {}
        dashboard.section.buttons.val = {
            -- dashboard.button("e", "explorer", ":Oil<CR>"),
            -- dashboard.button("e", "explorer", ":lua MiniFiles.open()<CR>"),
            dashboard.button("e", "explorer", ":Yazi<CR>"),
            dashboard.button("s", "search files", ":Telescope find_files<CR>"),
            dashboard.button("p", "restore session", ":lua require('persistence').load({ last = true })<CR>"),
            dashboard.button("l", "lazy", ":Lazy<CR>"),
            dashboard.button("m", "mason", ":Mason<CR>"),
            dashboard.button("q", "quit", ":qa<CR>"),
        }
        alpha.setup(dashboard.config)
    end,
}
