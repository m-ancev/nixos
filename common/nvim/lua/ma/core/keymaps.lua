-- Recenter view after using navigation shortcuts
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", "<C-f>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { noremap = true, silent = true })

-- Jump to start of line
vim.keymap.set("n", "<C-h>", "^", { noremap = true, silent = true })
-- Jump to end of line
vim.keymap.set("n", "<C-l>", "$", { noremap = true, silent = true })
-- Half page down
vim.keymap.set("n", "<C-j>", "<C-d>zz", { noremap = true, silent = true })
-- Half page up
vim.keymap.set("n", "<C-k>", "<C-u>zz", { noremap = true, silent = true })

-- Buffer Management
vim.keymap.set("n", "<leader><Tab>", ":bn<CR>", { desc = "buffer next" })
vim.keymap.set("n", "<leader><S-Tab>", ":bp<CR>", { desc = "buffer previous" })

-- Oil Explorer
-- vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "explorer" })
-- MiniFiles Explorer
-- vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<CR>", { desc = "explorer" })

-- Write All
vim.keymap.set("n", "<leader>w", ":wa<CR>", { desc = "write" })

-- Write Quit All
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "quit" })

-- Alpha Start Page
vim.keymap.set("n", "<leader>a", ":Alpha<CR>", { desc = "alpha" })

-- Format buffer
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, { desc = "format" })

-- Clear highlight search on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "next diagnostic" })
vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "show error" })

-- Toggle background color
vim.keymap.set("n", "<leader>tl", "<cmd>set background=light<CR>", { desc = "light" })
vim.keymap.set("n", "<leader>td", "<cmd>set background=dark<CR>", { desc = "dark" })
vim.keymap.set("n", "<leader>tt", "<cmd>TransparentToggle<CR>", { desc = "transparent" })
