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
		config = function()
			vim.api.nvim_create_autocmd({ "VimEnter" }, {
				callback = function(data)
					local real_file = vim.fn.filereadable(data.file) == 1
					local no_name = data.file == ""
						and vim.bo[data.buf].buftype == ""
						and vim.bo[data.buf].filetype == "Alpha"
					if not real_file and not no_name then
						return
					end
					require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
				end,
			})
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				renderer = {
					root_folder_label = false,
				},
				view = {
					width = {},
				},
			})
		end,
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
}
