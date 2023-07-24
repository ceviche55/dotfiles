require("catppuccin").setup({
  flavour = "mocha",
  background = "mocha",
  show_end_of_buffer = true,
  integrations = {
    cmp = true,
    nvimtree = true,
    telescope = true,
    mason = true,
    harpoon = true,
    markdown = true,
    -- gitsigns = true,
    -- notify = false,
    -- mini = false,
  },
})

vim.cmd.colorscheme "catppuccin"
vim.opt.background = 'dark'
