return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
					})
				end,
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.rustfmt,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.fish_indent,
					null_ls.builtins.formatting.taplo,
					null_ls.builtins.code_actions.eslint,
					null_ls.builtins.code_actions.shellcheck,
					null_ls.builtins.diagnostics.actionlint,
					null_ls.builtins.diagnostics.editorconfig_checker,
					null_ls.builtins.diagnostics.erb_lint,
					null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.diagnostics.shellcheck,
				},
				-- https://github.com/nvimtools/none-ls.nvim/wiki/Formatting-on-save
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "*",
		ft = { "rust" },
		cond = function()
			local f = io.open("Cargo.toml", "r")
			if f ~= nil then
				io.close(f)
				return true
			end
		end,
		opts = true,
	},
}
