vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', ':NvimTreeClose<CR>:q<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')

vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<leader>H', '<C-w>h')
vim.keymap.set('n', '<leader>J', '<C-w>j')
vim.keymap.set('n', '<leader>K', '<C-w>k')
vim.keymap.set('n', '<leader>L', '<C-w>l')

vim.keymap.set('n', '<leader>W', function()
  if vim.opt.wrap:get() then
    vim.opt.wrap = false
    print("Line wrapping disabled.")
  else
    vim.opt.wrap = true
    print("Line wrapping enabled.")
  end
end
)

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
