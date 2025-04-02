return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  },
  build = "make tiktoken",                          -- Only on MacOS or Linux
  cmd = { "CopilotChat", "CopilotChatExplain", "CopilotChatFix", "CopilotChatContext" },

  keys = {
    { "<leader>cc", "<cmd>CopilotChatToggle<cr>",          desc = "Copilot Chat" },
    { "<leader>ce", ":'<,'>CopilotChatExplain<CR>",        mode = "v",               desc = "Explain Code" },
    { "<leader>cf", ":'<,'>CopilotChatFix<CR>",            mode = "v",               desc = "Fix Code" },
    { "<leader>ct", "<cmd>CopilotChatContext tabpage<CR>", desc = "Context: Tabpage" },
    { "<leader>cb", "<cmd>CopilotChatContext buffer<CR>",  desc = "Context: Buffer" },
    { "<leader>cv", "<cmd>CopilotChatContext visible<CR>", desc = "Context: Visible" },
  },

  opts = {
    model = "claude-3.7-sonnet",
    debug = false,
    show_folds = false,
    context = "buffer", -- buffer, tabpage, visible
  },
  -- See Commands section for default commands if you want to lazy load on them
  --
}
