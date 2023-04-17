return {
   'nvim-treesitter/nvim-treesitter',
   config = function()
     require'nvim-treesitter.configs'.setup {
       ensure_installed = { "lua", "vim", "help", "query", "ruby", "go" },
       auto_install = true,
     }
   end
}
