return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- Extension plugin for Rust (preferred over lspconfig)
			{ "mrcjkb/rustaceanvim", version = "^5", ft = { "rust" } },
			"hrsh7th/cmp-nvim-lsp",
		},
		-- 1. key mapping
		keys = {
			{ "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
			{ "gr", vim.lsp.buf.references, desc = "References" },
			{ "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
			{ "<leader>ea", function()
				vim.diagnostics.open_float(nil, {
					scope = "buffer",
					border = "rounded",
					source = "always",
					focus = true,
				})
			end, { desc = "Diagnostics (buffer, floating)" }},
			{ "<leader>e", vim.diagnostic.open_float, desc = "Show Diagnostics" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
			{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
		},
		-- 2. configuration
		opts = {
			servers = {
				lua_ls = {
					settings = { Lua = { diagnostics = { globals = { "vim" } } }, },
				},
				stylua = {},
				pyright = {},
				ruff = {},
				gopls = {},
				terraformls = {},
				marksman = {},
			},
		},
		-- 3. bridge Mason and lspconfig
		config = function(_, opts)
			require("mason").setup()

			local ensure_installed = vim.tbl_keys(opts.servers)
			table.insert(ensure_installed, "rust_analyzer") -- install only; rustaceanvim handles the rest

			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
				automatic_enable = false,
			})

			-- for cmp
			local caps = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", { capabilities = caps })

			for server_name, server_ops in pairs(opts.servers) do
				if server_name ~= "rust_analyzer" then
					vim.lsp.config(server_name, server_opts)
				end
			end

			vim.lsp.config("pylight", {
				root_markers = { "uv.lock", ".venv", "pyproject.toml", ".git" },
				settings = {
					python = {
						pythonPath = "./.venv/bin/python",
						analysis = {
							diagnosticsSeverityOberrides = {
								reportUnusedImport = "none",
								reportUnusedVariable = "none",
							},
						},
					},
					pyright = {
						typeCheckingMode = "standard",
					},
				},
			})

			vim.lsp.config("ruff", {
				root_markers = { "uv.lock", ".venv", "pyproject.toml", ".git" },
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					-- ruff doesn't provide hover (usually want K to show pyright docs)
					if client.name == "ruff" then
						client.server_capabilities.hoverProvider = false
					end

					-- Optional: remove pyright as a formatter (it usually doesn't format, but just in case)
					if client.name == "pyright" then
						client.server_capabilities.documentFormattingProvider = false
					end
				end,
			})

			vim.lsp.enable({
				"lua_ls",
				"stylua",
				"pyright",
				"ruff",
				"gopls",
				"terraformls",
				"marksman",
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
