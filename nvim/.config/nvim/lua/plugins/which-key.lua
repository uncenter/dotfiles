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
					-- Clipboard --
					y = { '"+y', "Copy/yank to clipboard" },
					p = { '"+p', "Paste from clipboard" },

					-- Git --
					gp = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Git diff" },
					gb = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Git line blame" },
					gg = { "<cmd>LazyGit<cr>", "Open LazyGit" },

					-- Files --
					ft = { "<cmd>NvimTreeToggle<cr>", "Toggle file tree" },
					fe = { "<cmd>Yazi<cr>", "Open file explorer" },

					-- Buffer --
					bf = { vim.lsp.buf.format, "Format buffer" },

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
