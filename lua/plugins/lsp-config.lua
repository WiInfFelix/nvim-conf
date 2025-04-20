return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"debugpy",
			},
		},
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "vtsls", "ruff", "basedpyright", "lexical" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {},
		config = function()
			local lspconfig = require("lspconfig")
			local capas = require("blink.cmp").get_lsp_capabilities()

			lspconfig.lua_ls.setup({
				capabilities = capas,
			})
			lspconfig.ruff.setup({
				capabilities = capas,
				init_options = {
					settings = {
						args = {
							"--preview",
						},
						organizeImports = true,
						lineLength = 120,
						lint = {
							extendSelect = { "E501", "N", "R", "I" },
							preview = true,
							args = {
								"--preview",
							},
						},
					},
				},
			})

			lspconfig.basedpyright.setup({
				capabilities = capas,
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "standard",
							useLibraryCodeForTypes = true,
							autoImportCompletions = true,
							reportUnannotatedClassAttribute = false,
							autoSearchPaths = true,
							inlayHints = {
								callArgumentNames = true,
								variableTypes = true,
								functionReturnTypes = true,
							},
						},
						python = {
							pythonPath = "./.venv/bin/python",
						},
					},
				},
			})

      local util = vim.fs

			lspconfig.lexical.setup({
				capabilities = capas,
				cmd = { "/home/felixs/.elixir/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },

				filetypes = { "elixir", "eelixir", "heex" },
			})

			vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, {
				desc = "Hover definition of current symbol",
			})
			vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, {
				desc = "Go to definition of current symbol",
			})
			vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, {
				desc = "Show implementations of symbol",
			})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
				desc = "Show available code actions",
			})
		end,
	},
}
