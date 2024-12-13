return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon").setup({
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      global_settings = {
        save_on_toggle = true,
      },
    })
  end,
  keys = function()
    local harpoon_ui = require("harpoon.ui")
    local harpoon_mark = require("harpoon.mark")
    local keys = {
      {
        "<leader>H",
        function()
          harpoon_mark.add_file()
        end,
        desc = "Harpoon File",
      },
      {
        "<leader>h",
        function()
          harpoon_ui.toggle_quick_menu()
        end,
        desc = "Harpoon Quick Menu",
      },
      {
        "<leader>j",
        function()
          harpoon_ui.nav_file(1)
        end,
        desc = "Harpoon to File 1",
      },
      {
        "<leader>k",
        function()
          harpoon_ui.nav_file(2)
        end,
        desc = "Harpoon to File 2",
      },
      {
        "<leader>l",
        function()
          harpoon_ui.nav_file(3)
        end,
        desc = "Harpoon to File 3",
      },
      {
        "<leader>;",
        function()
          harpoon_ui.nav_file(4)
        end,
        desc = "Harpoon to File 4",
      },
    }
    return keys
  end,
}
