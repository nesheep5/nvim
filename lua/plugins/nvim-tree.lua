return {
  'nvim-tree/nvim-tree.lua',
  dependencies={'nvim-tree/nvim-web-devicons'},
  init = function()
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true
  end,

  keys = {
    { "<leader>ee", ":NvimTreeToggle<cr>", desc = "NvimTreeToggle" },
    { "<leader>ef", ":NvimTreeFindFile<cr>", desc = "NvimTreeFindFile" },
  },

  config = function()
    require("nvim-tree").setup( {
      sort_by = "case_sensitive",
      view = {
        width = 40,
        mappings = {
          list = {
            { key = "s", action = "" },
          },
        },
      },
      renderer = {
        group_empty = true,
      },
    })
  end,
}


