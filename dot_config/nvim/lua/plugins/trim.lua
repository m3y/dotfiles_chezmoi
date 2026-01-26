return {
	"cappyzawa/trim.nvim",
	opts = {
		ft_blocklist = { "markdown", "diff" },
		trim_on_write = false,
		trim_trailing_lines = true,
		highlight = true,
		ft_blocklist = {
		 	"oil",
		},
		buftype_blocklist = {
			"nofile",
			"terminal",
			"help",
			"quickfix",
		},
	}
}
