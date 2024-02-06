return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-frappe")
			require("catppuccin").setup({
				integrations = {
					nvimtree = true,
					barbar = true,
					gitsigns = true,
					navic = {
						enabled = true,
						custom_bg = "NONE",
					},
					which_key = true,
				},
			})
		end,
	},
}
