return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'rafamadriz/friendly-snippets',
    'saghen/blink.cmp',
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    local servers = {
      "lua_ls",
      "nil_ls",
      "jedi_language_server",
    }

    -- Capabilities for LSP servers
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Set up LSP servers
    for _, lsp in ipairs(servers) do
      require("lspconfig")[lsp].setup({ capabilities = capabilities })
    end

    -- Auto commands for LSP
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        local bufnr = args.buf
        local opts = { buffer = bufnr, remap = false }

        -- LSP keybindings
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
      end,
    })

    -- Set up nvim-cmp
    require('cmp').setup({
      sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      },
      mapping = {
        ['<C-n>'] = require('cmp').mapping.select_next_item(),
        ['<C-p>'] = require('cmp').mapping.select_prev_item(),
        ['<Tab>'] = require('cmp').mapping.confirm({ select = true }),
      },
    })
  end,
}
