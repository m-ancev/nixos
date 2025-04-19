return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- LSP management
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- completion engine + LSP source
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",

        -- extra completion sources
        "hrsh7th/cmp-buffer", -- buffer‑based completions
        "hrsh7th/cmp-path", -- filesystem path completions

        -- snippet engine + community snippets
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        "saadparwaiz1/cmp_luasnip",

        -- lua uv completions
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
        -- 1) mason + mason-lspconfig
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "gopls" },
            automatic_installation = true,
        })

        -- 2) capabilities & on_attach
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        local on_attach = function(client, bufnr)
            local wk = vim.keymap.set
            local opts = { buffer = bufnr, silent = true }
            wk("n", "gd", vim.lsp.buf.definition, opts)
            wk("n", "gr", vim.lsp.buf.references, opts)
            wk("n", "<leader>vr", vim.lsp.buf.rename, opts)
            wk("n", "<leader>vc", vim.lsp.buf.code_action, opts)
            vim.lsp.handlers["textDocument/hover"] =
                vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
            wk("n", "K", vim.lsp.buf.hover, opts)
        end

        -- 3) auto‑setup of all servers via mason-lspconfig handlers
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({
                    on_attach    = on_attach,
                    capabilities = capabilities,
                })
            end,
        })

        -- 4) nvim-cmp + snippets
        local cmp     = require("cmp")
        local luasnip = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = {
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                -- ["<C-Space>"] = cmp.mapping.complete(),  -- manual trigger (uncomment if you want)
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
                { name = "luasnip" },
            },
            window = {
                completion    = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        })
    end,
}
