return {
  'nvim-tree/nvim-tree.lua',
  dependencies={'nvim-tree/nvim-web-devicons'},
  keys = {
    { "fe", ":NvimTreeToggle<cr>", desc = "NvimTreeToggle" },
  },
  init = function()
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true
  end,
  config = {
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
  },
}
