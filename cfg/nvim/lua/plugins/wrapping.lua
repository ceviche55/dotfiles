return {
  "andrewferrier/wrapping.nvim",
  keys = function()
    return {
      { "<leader>ws", "<cmd>SoftWrapMode<cr>", desc = "Soft Wrap" },
      { "<leader>wh", "<cmd>HardWrapMode<cr>", desc = "Hard Wrap" },
      { "<leader>wt", "<cmd>ToggleWrapMode<cr>", desc = "Toggle Wrap" },
    }
  end,
  config = function()
    require("wrapping").setup()
  end,
}
