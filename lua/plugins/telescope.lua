return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.1",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    {
      "nvim-telescope/telescope-frecency.nvim",
      dependencies = {
        "kkharji/sqlite.lua",
      },
      keys = { { "<Leader>fr", ":Telescope frecency<CR>", desc = "frecency" } },
      config = function()
        require("telescope").load_extension("frecency")
      end,
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  keys = {
    { "<leader>ff", ":Telescope find_files<cr>", desc = "find files" },
    { "<leader>fg", ":Telescope live_grep<cr>",  desc = "live greps" },
    { "<leader>fb", ":Telescope buffers<cr>",    desc = "buffers" },
    { "<Leader>fo", ":Telescope oldfiles<CR>",   desc = "oldfiles" },
    { "<Leader>fh", ":Telescope help_tags<CR>",  desc = "help tags" },
  },
  config = function()
    require("telescope").setup({
      pickers = {
        find_files = {
          hidden = true,
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        frecency = {
          show_scores = true,
        }
      }
    })
  end,
}
