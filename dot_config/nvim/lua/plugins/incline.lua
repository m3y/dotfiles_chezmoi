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

				local function diag_segments()
					local severities = {
						{ key = "ERROR", icon = "E", hl = "DiagnosticSignError" },
						{ key = "WARN", icon = "W", hl = "DiagnosticSignWarn" },
					}

					local segs = {}
					for _, s in ipairs(severities) do
						local n = #vim.diagnostic.get(buf, {
							severity = vim.diagnostic.severity[s.key],
						})
						if n > 0 then
							table.insert(segs, { s.icon .. n .. " ", group = s.hl })
						end
					end

					if #segs > 0 then
						table.insert(segs, { "| " })
					end
					return segs
				end

				local function macro_segment()
					local rec = vim.fn.reg_recording()
					if rec ~= "" then
						return { "REC @" .. rec, guifg = "#ff5555", gui = "bold" }
					end

					return nil
				end

				local parts = {}

				vim.list_extend(parts, diag_segments())

				table.insert(parts, { icon, guifg = icon_color })
				table.insert(parts, " ")
				table.insert(parts, { filename, gui = readonly and "italic" or nil })

				if modified then
					table.insert(parts, { " ●", guifg = "#e86671" })
				end

				if readonly then
					table.insert(parts, { " ", guifg = "#e5c07b" })
				end

				local m = macro_segment()
				if m then
					table.insert(parts, { " | " })
					table.insert(parts, m)
				end

				return parts
			end,
		}
	end,
}
