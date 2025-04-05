return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    {
      "s1n7ax/nvim-window-picker", -- for open_with_window_picker keymaps
      version = "2.*",
      config = function()
        require("window-picker").setup({
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { "terminal", "quickfix" },
            },
          },
        })
      end,
    },
  },
  lazy = false, -- neo-tree will lazily load itself
  keys = {
    { "<leader>ee", "<cmd>Neotree toggle<cr>",     desc = "Toggle NeoTree" },
    { "<leader>f",  "<cmd>Neotree float<cr>",      desc = "NeoTree Float" },
    { "<leader>g",  "<cmd>Neotree git_status<cr>", desc = "NeoTree Git Status" },
  },
  opts = {
    window = {
      mappings = {
        -- Sとsを無効にする
        ["S"] = 'none',
        ["s"] = 'none',
      },
    },
  },
}
