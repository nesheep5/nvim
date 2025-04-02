-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gf", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  -- vim.keyqap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.ruby_lsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    formatter = 'syntax_tree',
  },
}

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup({
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
    })
  end,

  ["ts_ls"] = function()
    lspconfig.ts_ls.setup({
      on_attach = on_attach,
      filetypes = { "typescript", "typescriptreact", "typescript.tsx" }, -- jsはflowに任せる
    })
  end,

  ["eslint"] = function()
    lspconfig.eslint.setup({
      on_attach = on_attach,
      root_dir = lspconfig.util.root_pattern('package.json', '.git'),
    })
  end,

  ["sorbet"] = function()
    lspconfig.sorbet.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { 'bundle', 'exec', 'srb', 'tc', '--lsp' },
    }
  end,

  -- for Lua
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,

      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
  end,

  -- for Python
  ["ruff"] = function()
    lspconfig.ruff.setup({
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'glc', '<cmd>silent !ruff check --fix %<CR>',
          { noremap = true, silent = true })
      end,
      flags = lsp_flags,
      capabilities = capabilities,
      --[[
      init_options = {
        settings = {
          -- Ruff language server settings go here
      }
    })
--]]
    })
  end,
  ["pyright"] = function()
    lspconfig.pyright.setup({
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
      settings = {
        python = {
          -- 仮想環境のPythonを使う
          venvPath = ".",
          pythonPath = "./.venv/bin/python",
          analysis = {
            autoImportCompletions = true, -- オートインポート補完を有効化
          },
        }
      }
    })
  end,

})


lspconfig.flow.setup({
  on_attach = on_attach,
  flags = lsp_flags,
})
