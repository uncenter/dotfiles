return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = "*",
		build = ":TSUpdate",
		dependencies = {
			{
				"windwp/nvim-ts-autotag",
				main = "nvim-ts-autotag",
				opts = {},
			},
			{
				"nvim-treesitter/nvim-treesitter-context",
				opts = {
					enable = false,
				},
			},
		},
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				auto_install = true,
				auto_tag = { enable = true },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
