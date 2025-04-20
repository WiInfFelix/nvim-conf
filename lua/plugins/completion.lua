return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	version = "*",
	enabled = true,
	opts = {
		sources = {
			default = { "lazydev", "lsp", "path", "buffer" },
			providers = {
				lazydev = {
					name = "lazydev",
					module = "lazydev.integrations.blink",
					score_offset = 1100,
				},
				lsp = {
					name = "lsp",
					enabled = true,
					module = "blink.cmp.sources.lsp",
					score_offset = 1000,
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 250,
				},
				buffer = {
					name = "Buffer",
					module = "blink.cmp.sources.buffer",
					min_keyword_length = 4,
					score_offset = 150,
				},
				dadbod = {
					name = "dadbod",
					module = "vim_dadbod_completion.blink",
					score_offset = 950,
				},
			},
		},
		keymap = {
			preset = "enter",
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<S-k>"] = { "scroll_documentation_up", "fallback" },
			["<S-j>"] = { "scroll_documentation_down", "fallback" },
			["<C-b>"] = { "show" },
		},
		completion = {
			menu = {
				draw = {
					columns = {
						{
							"label",
							"label_description",
							gap = 1,
						},
						{ "kind_icon", "kind" },
					},
				},
				auto_show = function(ctx)
					return ctx.mode ~= "cmdline"
				end,
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
			},
			ghost_text = {
				enabled = false,
			},
		},
		snippets = {
			preset = "default",
		},
		signature = {
			enabled = true,
		},
	},
}
