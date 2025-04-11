-- Fuzzy Finder (files, lsp, etc)
return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },

        -- Useful for getting pretty icons, but requires a Nerd Font.
        { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
    },
    config = function()
        local actions = require("telescope.actions")
        local custom = {
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "bottom",
                    preview_width = 0.7,
                    results_width = 0.3,
                },
                vertical = {
                    mirror = false,
                },
                width = { padding = 0 },
                height = { padding = 0 },
                preview_cutoff = 120,
            },
            border = true,
            borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            -- Empty borderchars
            -- borderchars = { "", "", "", "", "", "", "", "" },
            color_devicons = false,
            winblend = 0,
            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                },
                n = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                }
            }
        }


        require("telescope").setup({
            defaults = custom,
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
        })

        -- Enable Telescope extensions if they are installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        -- See `:help telescope.builtin`
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "keymaps" })
        vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "telescope function" })
        vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "word" })
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "grep" })
        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "diagnostics" })
        vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "resume" })
        vim.keymap.set("n", "<leader>so", builtin.oldfiles, { desc = 'old' })

        -- Open help page in full screen buffer
        vim.keymap.set("n", "<leader>sh", function()
            require("telescope.builtin").help_tags({
                attach_mappings = function(prompt_bufnr, map)
                    local action_state = require("telescope.actions.state")
                    actions.select_default:replace(function()
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        vim.cmd("help " .. selection.value .. " | only")
                    end)
                    return true
                end,
            })
        end, { desc = "help" })

        -- autocmd to make help buffer listed for telescope navigation
        vim.api.nvim_create_augroup("ListHelpBuffers", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            group = "ListHelpBuffers",
            pattern = "help",
            callback = function()
                vim.bo.buflisted = true
            end,
        })

        -- Show hidden file when doing a file search
        vim.keymap.set("n", "<leader>sf", function()
            require("telescope.builtin").find_files({ hidden = true })
        end, { desc = "files" })

        -- Add binding to remove entry from buffer view
        vim.keymap.set("n", "<leader><leader>", function()
            builtin.buffers({
                theme = "dropdown",
                previewer = false,
                prompt_position = "bottom",
                sorting_strategy = "descending",
                layout_config = {
                    anchor = "CENTER",
                    width = 0.5,
                    height = 0.4,
                },
                attach_mappings = function(prompt_bufnr, map)
                    local delete_buf = function()
                        local state = require("telescope.actions.state")
                        local picker = state.get_current_picker(prompt_bufnr)
                        picker:delete_selection(function(selection)
                            vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                        end)
                    end
                    map("i", "<C-d>", delete_buf)
                    map("n", "<C-d>", delete_buf)
                    return true
                end,
            })
        end, { desc = "buffers" })

        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set("n", "<leader>/", function()
            -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 0,
                previewer = false,
            }))
        end, { desc = "fuzzy" })

        -- It's also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        vim.keymap.set("n", "<leader>s/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            })
        end, { desc = "grep buffers" })

        -- Shortcut for searching your Neovim configuration files on NixOS / Home Manager
        vim.keymap.set("n", "<leader>sn", function()
            builtin.find_files({ cwd = '~/nixos/common/nvim' })
        end, { desc = "neovim" })

        -- Shortcut for searching your Neovim configuration files in imperative configurations
        -- vim.keymap.set("n", "<leader>sn", function()
        --   builtin.find_files({ cwd = vim.fn.stdpath("config") })
        -- end, { desc = "[S]earch [N]eovim files" })

        -- Preview colorscheme from Telescope
        local action_state = require("telescope.actions.state")

        local function custom_colorscheme_picker()
            require("telescope.builtin").colorscheme({

                layout_strategy = "bottom_pane", -- Use the bottom pane layout
                layout_config = {
                    height = 0.5,                -- Occupy the lower half of the screen
                    preview_cutoff = 40,         -- Adjust as needed for your display
                },

                attach_mappings = function(prompt_bufnr, map)
                    local function update_preview()
                        local selection = action_state.get_selected_entry()
                        if selection and selection.value then
                            vim.cmd("colorscheme " .. selection.value)
                        end
                    end

                    map("i", "<C-j>", function()
                        actions.move_selection_next(prompt_bufnr)
                        update_preview()
                    end)

                    map("i", "<C-k>", function()
                        actions.move_selection_previous(prompt_bufnr)
                        update_preview()
                    end)

                    return true
                end,
            })
        end

        vim.keymap.set("n", "<leader>st", custom_colorscheme_picker, { desc = "theme" })
    end,
}
