return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context'
  },
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = { "fish", "lua", "vim", "query", "ruby", "go" },
      auto_install = true,
      highlight = {
        enable = true,
      }
    }
    require 'treesitter-context'.setup {
      enable = true,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = 'outer',
      mode = 'cursor',
      zindex = 20,
      on_attach = nil,
      win_opts = {},
    }
  end
}
