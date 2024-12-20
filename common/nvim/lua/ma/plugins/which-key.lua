return {
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require("which-key").setup()

    -- Document existing key chains
    require("which-key").add({
      { "<leader>c",  group = "[C]ode" },
      { "<leader>c_", hidden = true },

      { "<leader>d",  group = "[D]ocument" },
      { "<leader>d_", hidden = true },

      { "<leader>r",  group = "[R]ename" },
      { "<leader>r_", hidden = true },

      { "<leader>s",  group = "[S]earch" },
      { "<leader>s_", hidden = true },

      { "<leader>w",  group = "[W]orkspace" },
      { "<leader>w_", hidden = true },

      { "<leader>t",  group = "[T]oggle" },
      { "<leader>t_", hidden = true },

      { "<leader>T",  group = "[T]heme" },
      { "<leader>T_", hidden = true },

      { "<leader>n",  group = "[N]o" },
      { "<leader>n_", hidden = true },
    })
  end,
}
