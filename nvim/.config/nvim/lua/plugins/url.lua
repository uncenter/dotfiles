return {
	{
		"axieax/urlview.nvim",
		cmd = "UrlView",
		opts = true,
		dependencies = {
			{ "nvim-telescope/telescope.nvim", version = "*" },
		},
		config = function()
			require("urlview").setup({
				default_picker = "telescope",
			})
		end,
	},
}
