return {
  enabled = true,
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "[U]ndotree Toggle" })
  end
}
