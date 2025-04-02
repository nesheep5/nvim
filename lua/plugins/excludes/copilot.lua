return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",         -- コマンド実行で読み込まれる（手動起動用）
  event = "InsertEnter",   -- 自動起動したいならこれ追加
  build = ":Copilot auth", -- 初回ログイン時に必要
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<C-l>",
      },
    },
    panel = {
      enabled = true,
      auto_refresh = true,
      keymap = {
        jump_next = "<C-j>",
        jump_prev = "<C-k>",
        accept = "<C-l>",
        refresh = "r",
        open = "<C-\\>",
      },
    },
  },
  config = function(_, opts)
    require("copilot").setup(opts)
  end,
}
