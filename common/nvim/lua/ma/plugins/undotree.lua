return {
  enabled = true,
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "[U]ndotree Toggle" })
    -- hard dependency for windows
    -- vim.g.undotree_DiffCommand = "FC"
  end
}
