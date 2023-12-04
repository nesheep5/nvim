local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.del('n', 's', { buffer = bufnr })
end

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  init = function()
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true
  end,

  keys = {
    { "<leader>ee", ":NvimTreeFindFileToggle<cr>", desc = "NvimTreeFindFileToggle" },
  },

  config = function()
    require("nvim-tree").setup({
      on_attach = my_on_attach,
      sort_by = "case_sensitive",
      view = {
        width = 40,
      },
      renderer = {
        group_empty = true,
      },
      update_focused_file = {
        enable = true,
      },
    })
  end,
}
