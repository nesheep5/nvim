return {
  'hrsh7th/nvim-cmp',
  tag = "v0.0.2",
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind-nvim',
    {
      'zbirenbaum/copilot.lua',
      cmd = "Copilot",
      event = "InsertEnter",
    },
    {
      'zbirenbaum/copilot-cmp',
      dependencies = { 'zbirenbaum/copilot.lua' },
    },
    {
      'petertriho/cmp-git',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require("cmp_git").setup()
      end
    },
  },

  config = function()
    local cmp = require 'cmp'
    local lspkind = require('lspkind')

    -- Copilot setup
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
    require("copilot_cmp").setup()

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          maxwidth = {
            menu = 50,              -- leading text (labelDetails)
            abbr = 50,              -- actual suggestion item
          },
          ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default
        })
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            require("luasnip").expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = 'copilot',  group_index = 1 },
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'luasnip',  group_index = 2 },
        { name = 'path',     group_index = 2 },
      }, {
        { name = 'buffer', group_index = 3 },
      })
    })

    -- Git commit message 用補完
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'cmp_git' },
      }, {
        { name = 'buffer' },
      })
    })

    -- 検索（/ or ?）用
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- コマンドライン補完（:）
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })
  end
}
