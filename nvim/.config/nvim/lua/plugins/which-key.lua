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
					g = {
						name = "+git",
						p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Git diff" },
						b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Git line blame" },
						g = { "<cmd>LazyGit<cr>", "Open LazyGit" },
					},

					-- Files --
					f = {
						name = "+file",
						t = { "<cmd>NvimTreeToggle<cr>", "Toggle file tree" },
						e = { "<cmd>Yazi<cr>", "Open file explorer" },
					},

					-- Buffer --
					b = {
						name = "+buffer",
						s = { "<cmd>w<cr>", "Save buffer" },
						f = { vim.lsp.buf.format, "Format buffer" },
						c = { "<cmd>%y+<cr>", "Copy buffer" },
					},

					-- LSP --
					l = {
						name = "+lsp",
						g = {
							name = "+goto",
							d = { vim.lsp.buf.definition, "Definition" },
							r = { vim.lsp.buf.references, "References" },
						},
						r = { vim.lsp.buf.rename, "Rename" },
						a = { vim.lsp.buf.code_action, "Code actions" },
					},

					q = { "<cmd>qall<cr>", "Quit all" },
				},
			}, { mode = { "n", "v" } })

			wk.register({
				["<C-s>"] = {
					"<cmd>w<cr>",
					"Save file",
				},
			})
		end,
		opts = {},
	},
}
