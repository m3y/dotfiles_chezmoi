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
			render = function(props)
				local buf = props.buf
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
				return {
					vim.bo[buf].readonly and "RO " or "",
					filename,
				}
			end,
		})
	end,
	event = "VeryLazy",
}
