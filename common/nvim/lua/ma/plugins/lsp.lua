return {
    "neovim/nvim-lspconfig",
    dependencies = {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'rafamadriz/friendly-snippets',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        "williamboman/mason.nvim",
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
            "gopls",
        }

        -- Capabilities for LSP servers
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- set up lsp servers
        for _, lsp in ipairs(servers) do
            require("lspconfig")[lsp].setup({ capabilities = capabilities })
        end

        -- auto commands for lsp
        vim.api.nvim_create_autocmd('lspattach', {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then return end

                local bufnr = args.buf
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "references" })
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "definition" })
                vim.keymap.set("n", "<leader>vc", vim.lsp.buf.code_action, { desc = "code action" })
                vim.keymap.set("n", "<leader>vr", vim.lsp.buf.rename, { desc = "rename" })

                -- Override the default hover handler with a border setting:
                vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                    vim.lsp.handlers.hover, {
                        border = "single",
                    }
                )
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            end,
        })

        -- set up nvim-cmp
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
            },
            mapping = {
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                -- This mapping conflicts with tmux
                -- ['<C-Space>'] = cmp.mapping.complete(),
            },
        })

        -- mason for docker env
        require("mason").setup()
    end,
}
