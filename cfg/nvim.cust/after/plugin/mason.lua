require("mason").setup()
require("mason-lspconfig").setup{
  ensure_installed = { "lua_ls" },
}

vim.keymap.set("n", "<leader>M", vim.cmd.Mason)
