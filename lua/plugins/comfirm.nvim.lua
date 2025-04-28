return {
  'stevearc/conform.nvim',
  opts = {
    default_format_opts = {
      lsp_format = "fallback", -- 外部フォーマッタがない場合のみ LSP を使う
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      ruby = { "syntax_tree" },
      javascript = { "prettier", "eslint" },
    },
    -- ファイル保存時にフォーマットを実行する
    format_on_save = {
      timeout_ms = 500,
    },
  },
}
