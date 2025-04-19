return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
        -- check the installation instructions at
        -- https://github.com/folke/snacks.nvim
        "folke/snacks.nvim"
    },
    keys = {
        -- in this section, choose your own keymappings!
        {
            "<leader>e",
            mode = { "n", "v" },
            "<cmd>Yazi<cr>",
            desc = "explorer",
        },
    },

  opts = {
    open_for_directories = true,

    -- if you use `open_for_directories=true`, this is recommended
    init = function()
        -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
        -- vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,

    -- the floating window scaling factor. 1 means 100%, 0.9 means 90%, etc.
    floating_window_scaling_factor = 1,

    -- customize the keymaps that are active when yazi is open and focused. The
    -- defaults are listed below. Note that the keymaps simply hijack input and
    -- they are never sent to yazi, so only try to map keys that are never
    -- needed by yazi.
    --
    -- Also:
    -- - use e.g. `open_file_in_tab = false` to disable a keymap
    -- - you can customize only some of the keymaps (not all of them)
    -- - you can opt out of all keymaps by setting `keymaps = false`
    keymaps = {
      show_help = "<f1>",
      open_file_in_vertical_split = "<c-v>",
      open_file_in_horizontal_split = "<c-x>",
      open_file_in_tab = "<c-t>",
      grep_in_directory = "<c-s>",
      replace_in_directory = "<c-g>",
      cycle_open_buffers = "<tab>",
      copy_relative_path_to_selected_files = "<c-y>",
      send_to_quickfix_list = "<c-q>",
      change_working_directory = "<c-\\>",
    },

    -- the type of border to use for the floating window. Can be many values,
    -- including 'none', 'rounded', 'single', 'double', 'shadow', etc. For
    -- more information, see :h nvim_open_win
    yazi_floating_window_border = "none",

    -- some yazi.nvim commands copy text to the clipboard. This is the register
    -- yazi.nvim should use for copying. Defaults to "*", the system clipboard
    clipboard_register = "*",
  },
}
