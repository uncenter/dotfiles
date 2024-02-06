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
