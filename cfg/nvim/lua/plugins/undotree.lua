return {
  "mbbill/undotree",
  keys = {
    { "<leader>ut", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree UI" },
  },
  config = function()
    vim.g.undotree_WindowLayout = 3
    vim.g.undotree_ShortIndicators = 1
  end,
}
