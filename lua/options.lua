
vim.opt.number = true
vim.opt.swapfile = false

local undodir = os.getenv( "HOME" ) .. '/.local/nvim/undodir'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir
vim.opt.undofile = true

vim.opt.keywordprg = ':help'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab  = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.clipboard:append{'unnamedplus'}
vim.opt.scrolloff = 10
vim.opt.laststatus = 3

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

