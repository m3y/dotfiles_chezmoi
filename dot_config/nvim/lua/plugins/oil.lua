return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "-", "<cmd>Oil --float<CR>", desc = "Oil (float)" },
		{
			"<C-x>",
			function()
				require("oil").select({ horizontal = true })
			end,
			mode = "n",
			ft = "oil",
			desc = "Oil: open in horizontal split",
		},
		{
			"<C-v>",
			function()
				require("oil").select({ vertical = true })
			end,
			mode = "n",
			ft = "oil",
			desc = "Oil: open in vertical split",
		},
	},
	opts = {
		float = {
			padding = 2,
			max_width = 0.8,
			max_height = 0.8,
			border = "rounded",
		},
		view_options = {
			show_hidden = true,
		},
		preview_win = {
			update_on_cursor_moved = true,
			preview_method = "fast_scratch",
			disable_preview = function(filename)
				return false
			end,
		},
	},
}
