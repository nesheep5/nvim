vim.diagnostic.config({ virtual_text = true })
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_client, bufnr)
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
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
end

require("mason").setup()
local mason_ensure_installed = { "lua_ls", "ts_ls", "eslint" }
require("mason-lspconfig").setup({
	automatic_installation = true,
	ensure_installed = mason_ensure_installed,
})

vim.lsp.config("*", {
	on_attach = on_attach,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	flags = {
		debounce_text_changes = 150,
	},
})
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
vim.lsp.config("ruby_lsp", {
	cmd = { "mise", "exec", "ruby@3.2.8", "--", "bundle", "exec", "ruby-lsp" },
	root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git"),
	init_options = { formatter = "syntax_tree" },
})
vim.lsp.config("sorbet", {
	cmd = { "mise", "exec", "ruby@3.2.8", "--", "bundle", "exec", "srb", "tc", "--lsp" },
})
vim.lsp.config("ts_ls", {
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" }, -- jsはflowに任せる
})
vim.lsp.config("eslint", {
	root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
})
vim.lsp.config("pyright", {
	settings = {
		python = {
			-- 仮想環境のPythonを使う
			venvPath = ".",
			pythonPath = "./.venv/bin/python",
			analysis = {
				autoImportCompletions = true, -- オートインポート補完を有効化
			},
		},
	},
})
vim.lsp.config("ruff", {
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"glc",
			"<cmd>silent !ruff check --fix %<CR>",
			{ noremap = true, silent = true }
		)
	end,
})

vim.lsp.enable("lua_ls", "ts_ls", "eslint", "flow", "ruby_lsp", "sorubet", "pyright", "ruff")
