return {
  "neovim/nvim-lspconfig",
  dependencies = { 'saghen/blink.cmp',
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
      -- add more servers here
    }

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    for _, lsp in ipairs(servers) do
      require("lspconfig")[lsp].setup({ capabilities = capabilities })
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        local bufnr = args.buf
        local opts = { buffer = bufnr, remap = false }

        -- Keybindings
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end,
          vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
          vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition" }))
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end,
          vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" }))
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
          vim.tbl_deep_extend("force", opts, { desc = "LSP Workspace Symbol" }))
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.setloclist() end,
          vim.tbl_deep_extend("force", opts, { desc = "LSP Show Diagnostics" }))
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end,
          vim.tbl_deep_extend("force", opts, { desc = "Next Diagnostic" }))
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end,
          vim.tbl_deep_extend("force", opts, { desc = "Previous Diagnostic" }))
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
          vim.tbl_deep_extend("force", opts, { desc = "LSP Code Action" }))
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
          vim.tbl_deep_extend("force", opts, { desc = "LSP References" }))
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end,
          vim.tbl_deep_extend("force", opts, { desc = "LSP Rename" }))
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
          vim.tbl_deep_extend("force", opts, { desc = "LSP Signature Help" }))

        -- Uncomment the following block for format on save functionality
        -- if client.supports_method('textDocument/formatting') then
        --   vim.api.nvim_create_autocmd('BufWritePre', {
        --     buffer = bufnr,
        --     callback = function()
        --       vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
        --     end,
        --   })
        -- end
      end,
    })
  end,
}
