return {
	{
		"axieax/urlview.nvim",
		cmd = "UrlView",
		dependencies = {
			{ "nvim-telescope/telescope.nvim", version = "*" },
		},
		opts = {
			default_picker = "telescope",
			default_action = "system",
		},
	},
}
