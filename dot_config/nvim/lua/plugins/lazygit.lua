return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	keys = {
		{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit (project)" },
		{ "<leader>gf", "<cmd>LazyGitCurrentFile<CR>", desc = "LazyGit (current file)" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
