vim.keymap.set("i", "jj", "<ESC>")

-- window
vim.keymap.set("n", "ss", "<c-w>s")
vim.keymap.set("n", "sv", "<c-w>v")
vim.keymap.set("n", "sh", "<c-w>h")
vim.keymap.set("n", "sj", "<c-w>j")
vim.keymap.set("n", "sk", "<c-w>k")
vim.keymap.set("n", "sl", "<c-w>l")

vim.keymap.set("n", "<leader>,", ":e ~/.config/nvim/init.lua<cr>")
