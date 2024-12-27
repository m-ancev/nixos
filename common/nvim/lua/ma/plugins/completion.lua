return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
      keymap = { preset = 'super-tab' },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      signature = { enabled = true }
    },
    config = function()
      require('cmp').setup({
        enabled = function()
          -- Get the current buffer filetype
          local buf_ft = vim.bo.filetype

          -- Disable completion in Telescope prompt buffers
          if buf_ft == "TelescopePrompt" then
            return false
          end

          -- Enable completion everywhere else
          return true
        end,
      })
    end,
  }
}
