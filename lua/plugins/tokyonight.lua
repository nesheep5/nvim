return {
  'folke/tokyonight.nvim',
  config = function()
    require("tokyonight").setup({
     on_colors = function(colors)
      colors.border = "#565f89"
    end
    })

    vim.cmd([[colorscheme tokyonight]])
  end
}
