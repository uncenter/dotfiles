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
