return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope-project.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			local tl = require("telescope")

			tl.load_extension("ui-select")
			tl.load_extension("project")

			local builtin = require("telescope.builtin")
			local wk = require("which-key")

			wk.register({
				["<leader>f"] = {
					d = { builtin.find_files, "Find files" },
					g = { builtin.live_grep, "Live grep" },
					p = { "<cmd>Telescope project<cr>", "Projects" },
				},
			})
		end,
	},
}
