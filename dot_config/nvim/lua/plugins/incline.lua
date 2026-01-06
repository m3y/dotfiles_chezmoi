return {
	"b0o/incline.nvim",
	config = function()
		require('incline').setup({
			window = {
				placement = {
					vertical = "bottom",
					horizontal = "right",
				},
				padding = 1,
				margin = {
					vertical = 0,
					horizontal = 1,
				},
			},
		})
	end,
	event = "VeryLazy",
}
