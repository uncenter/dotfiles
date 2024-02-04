return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 100

			local wk = require("which-key")

			wk.setup()

			wk.register({
				["<leader>"] = {
					y = { '"+y', "Copy to clipboard" },
					p = { '"+p', "Paste from clipboard" },
					gp = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Git diff" },
					gb = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Git line blame" },
					gg = { "<cmd>LazyGit<cr>", "LazyGit" },
					q = { "<cmd>qall<cr>", "Quit all" },
				},
			}, { mode = { "n", "v" } })

			wk.register({
				["<C-s>"] = {
					"<cmd>w<cr>",
					"Save File",
				},
			})
		end,
		opts = {},
	},
}
