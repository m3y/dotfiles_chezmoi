return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- Extension plugin for Rust (preferred over lspconfig)
			{ "mrcjkb/rustaceanvim", version = "^5", ft = { "rust" } },
		},
		-- 1. key mapping
		keys = {
			{ "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
			{ "gr", vim.lsp.buf.references, desc = "References" },
			{ "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
			{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
		},
		-- 2. configuration
		opts = {
			servers = {
				lua_ls = {
					settings = { Lua = { diagnostics = { globals = { "vim" } } }, },
				},
				pyright = {},
				gopls = {},
				terraformls = {},
				marksman = {},
			},
		},
		-- 3. bridge Mason and lspconfig
		config = function(_, opts)
			require("mason").setup()

			local ensure_installed = vim.tbl_keys(opts.servers)
			table.insert(ensure_installed, "rust_analyzer")

			local m_lsp = require("mason-lspconfig")
			m_lsp.setup({
				ensure_installed = ensure_installed,
			})

			local lspconfig = require("lspconfig")
			m_lsp.setup_handlers({
				function(server_name)
					-- Since rust_analyzer is managed by rustaceanvim, you can skip configuring it with lspconfig.
					if server_name == "rust_analyzer" then
						return
					end

					local server_opts = opts.servers[server_name] or {}
					lspconfig[server_name].setup(server_opts)
				end,
			})
		end,
	},
	-- for Mason
	{
		"williamboman/mason.nvim",
		opts = {
			ui = { border = "rounded" },
		},
	},
}
