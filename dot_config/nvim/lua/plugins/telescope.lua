return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- optional but recommended
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	cmd = "Telescope",
	keys = {
		-- Default find_files (starts from Neovim's cwd)
		{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Telescope: find files (cwd)" },
		-- find_files starting from the current file's project root
		{
			"<leader>fr",
			function()
				local builtin = require("telescope.builtin")

				-- Determine the start directory safely
				local bufname = vim.api.nvim_buf_get_name(0)
				local start = (bufname ~= "" and vim.fs.dirname(bufname)) or vim.loop.cwd()
				-- Root detection: prefer .git, etc.
				local root
				if vim.fs and vim.fs.root then
					root = vim.fs.root(start, { ".git", "package.json", "pyproject.toml", "go.mod", "Cargo.toml" })
				end
				root = root or start

				builtin.find_files({
					cwd = root,
					prompt_title = "Find files (file's project root)",
				})
			end,
			desc = "Telescope: find files (file's project root)",
		},
		-- Also for grep (both default and file-root variants)
		{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Telescope: live grep (cwd)" },
	},
	opts = {
		defaults = {
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				prompt_position = "top",
				-- width = 0.6,
				-- height = 0.7,
			},
		},
	},
}
