return {
	{
		"DreamMaoMao/yazi.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			theme = "catppuccin-frappe",
		},
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		after = "catppuccin",
		config = function()
			local bufferline = require("bufferline")

			local v = vim.version()
			local vStr = string.format("v%d.%d.%d", v.major, v.minor, v.patch)

			bufferline.setup({
				highlights = require("catppuccin.groups.integrations.bufferline").get(),
				options = {
					show_close_icon = false,
					show_buffer_close_icons = false,
					offsets = {
						{
							filetype = "NvimTree",
							text = "   Neovim " .. vStr,
							text_align = "left",
							separator = "│",
						},
					},
				},
			})
		end,
	},
}
