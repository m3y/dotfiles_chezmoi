return {
	"b0o/incline.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = function()
		local devicons = require("nvim-web-devicons")

		return {
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
				local bufname = vim.api.nvim_buf_get_name(buf)
				local filename = vim.fn.fnamemodify(bufname, ":t")
				if filename == "" then
					filename = "[No Name]"
				end

				local icon, icon_color = devicons.get_icon_color(filename, nil, { default = true })

				local modified = vim.bo[buf].modified
				local readonly = vim.bo[buf].readonly or not vim.bo[buf].modifiable

				local function diag_label()
					local severities = {
						{ key = "ERROR", icon = "E", hl = "DiagnosticSignError" },
						{ key = "WARN", icon = "W", hl = "DiagnosticSignWarn" },
					}

					local out = {}
					for _, s in ipairs(severities) do
						local n = #vim.diagnostic.get(props.buf, {
							severity = vim.diagnostic.severity[s.key],
						})
						if n > 0 then
							table.insert(out, { s.icon .. n .. " ", group = s.hl })
						end
					end

					if #out > 0 then
						table.insert(out, { "| " })
					end
					return out
				end

				return {
					{ diag_label() },
					{ icon, guifg = icon_color },
					" ",
					{ filename, gui = readonly and "italic" or nil },
					modified and { " ●", guifg = "#e86671" } or nil, -- modified mark
					readonly and { " ", guifg = "#e5c07b" } or nil, -- lock mark
				}
			end,
		}
	end,
}
