return {
	"gh-markdown-preview-integration",
	name = "gh-markdown-preview-integration",
	dir = vim.fn.stdpath("config"),
	lazy = false,
	init = function()
		local job_id = nil

		local function is_markdown(bufnr)
			local ft = vim.bo[bufnr].filetype
			return ft == "markdown" or ft == "md"
		end

		local function toggle()
			local bufnr = vim.api.nvim_get_current_buf()
			if not is_markdown(bufnr) then
				vim.notify("Not a markdown buffer", vim.log.levels.WARN)
				return
			end

			if job_id and job_id > 0 then
				vim.fn.jobstop(job_id)
				job_id = nil
				vim.notify("gh markdown-preview stopped")
				return
			end

			local file = vim.api.nvim_buf_get_name(bufnr)
			if file == "" then
				vim.notify("Buffer has no file path. Save it first.", vim.log.levels.WARN)
				return
			end

			job_id = vim.fn.jobstart({ "gh", "markdown-preview", file }, {
				stdout_buffered = true,
				stderr_buffered = true,
				on_exit = function()
					job_id = nil
				end,
			})

			if job_id <= 0 then
				job_id = nil
				vim.notify("Failed to start: gh markdown-preview (check gh + extension install)", vim.log.levels.ERROR)
			else
				vim.notify("gh markdown-preview started (default: http://localhost:3333)")
			end
		end

		vim.api.nvim_create_user_command("GhMarkdownPreviewToggle", toggle, {})

		vim.keymap.set("n", "<leader>pm", "<cmd>GhMarkdownPreviewToggle<CR>", {
			desc = "Toggle gh markdown-preview",
			silent = true,
		})
	end,
}
