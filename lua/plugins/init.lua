local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  require("plugins.tokyonight"),
  require("plugins.lualine"),
  require 'plugins.telescope',
  require("plugins.nvim-tree"),
  require('plugins.nvim-treesitter'),
  require("plugins.gitsigns"),
  require("plugins.fzf"),
  require("plugins.nvim-cmp"),
  require("plugins.nvim-surround"),

  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  require("plugins.null-ls"),

  require 'plugins.nvim-osc52',
})
