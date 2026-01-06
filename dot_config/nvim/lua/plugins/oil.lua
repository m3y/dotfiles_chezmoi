return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "-", "<cmd>Oil --float<CR>", desc = "Oil (float)" },
	},
	opts = {
		float = {
			padding = 2,
			max_width = 0.8,
			max_height = 0.8,
			border = "rounded",
		},
	},
}
