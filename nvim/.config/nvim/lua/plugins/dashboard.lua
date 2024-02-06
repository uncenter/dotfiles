return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"Shatur/neovim-session-manager",
	},
	config = function()
		require("session_manager").setup({
			autoload_mode = "CurrentDir",
		})

		local function apply_gradient_hl(text)
			local lines = {}
			for i, line in ipairs(text) do
				local tbl = {
					type = "text",
					val = line,
					opts = {
						hl = "HeaderGradient" .. i,
						shrink_margin = false,
						position = "center",
					},
				}
				table.insert(lines, tbl)
			end

			return {
				type = "group",
				val = lines,
				opts = { position = "center" },
			}
		end

		local alpha = require("alpha")
		local theta = require("alpha.themes.theta")
		local dashboard = require("alpha.themes.dashboard")

		local header = {
			"  ／l、    ",
			"（ﾟ､ ｡ ７  ",
			"  l  ~ヽ  ",
			"  じしf_,)ノ",
		}

		local buttons = {
			type = "group",
			position = "center",
			val = {
				dashboard.button("n", "  New file", ":ene <bar> startinsert <cr>"),
				dashboard.button("SPC fd", "  Find file", ":Telescope find_files<cr>"),
				dashboard.button("SPC fg", "  Live grep", ":Telescope live_grep<cr>"),
				dashboard.button("s", "  Show sessions", ":SessionManager load_session<cr>"),
				dashboard.button("SPC fp", "  Projects", ":Telescope project<CR>"),
				dashboard.button("q", "  Quit", ":qall<CR>"),
			},
		}

		local v = vim.version()
		local vStr = string.format("v%d.%d.%d", v.major, v.minor, v.patch)

		local footer = {
			type = "group",
			position = "center",
			val = {
				{
					type = "text",
					val = "Neovim " .. vStr,
					opts = { hl = "Comment", position = "center" },
				},
				{
					type = "text",
					val = require("lazy").stats().count .. " plugins",
					opts = { hl = "Comment", position = "center" },
				},
			},
		}
		dashboard.config.opts.noautocmd = true

		theta.config.layout = {
			{ type = "padding", val = 2 },
			apply_gradient_hl(header),
			{ type = "padding", val = 1 },
			buttons,
			{ type = "padding", val = 1 },
			footer,
		}

		alpha.setup(theta.config)
		vim.cmd([[autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2]])
	end,
}
