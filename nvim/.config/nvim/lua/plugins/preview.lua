return {
	{
		"iamcco/markdown-preview.nvim",
		version = "*",
		ft = "markdown",
		build = ":call mkdp#util#install()",
	},
}
