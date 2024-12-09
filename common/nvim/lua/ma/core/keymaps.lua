-- Oil Explorer
vim.keymap.set("n", "<leader>e", ":Oil --float<CR>", { desc = "Toggle Oil [E]xplorer" })

-- Alpha Start Page
vim.keymap.set("n", "<leader>a", ":Alpha<CR>", { desc = "Toggle [A]lpha" })

-- Buffer management
vim.keymap.set("n", "<leader><Tab>", ":bnext<CR>", { desc = "Open buffer next", noremap = true, silent = true })
vim.keymap.set("n", "<leader><S-Tab>", ":bprev<CR>", { desc = "Open buffer previous", noremap = true, silent = true })
vim.keymap.set("n", "<leader>k", ":bd<CR>", { desc = "[k]ill buffer", noremap = true, silent = true })

-- Format buffer
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, { desc = "Format buffer" })

-- Bufferline keymaps
vim.keymap.set("n", "gb", ":BufferLinePick<CR>", { desc = "Toggle BufferLinePick", noremap = true, silent = true })

-- Clear highlight search on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Toggle background color
vim.keymap.set("n", "<leader>Tl", "<cmd>set background=light<CR>", { desc = "[T]heme [l]ight" })
vim.keymap.set("n", "<leader>Td", "<cmd>set background=dark<CR>", { desc = "[T]heme [d]ark" })
