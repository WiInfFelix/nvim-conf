return {
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		priority = 999,
		config = function()
			require("kanagawa").setup()
		end,
	},
	{
		"neanias/everforest-nvim",
		name = "everforest",
		priority = 999,
		config = function()
			require("everforest").setup()
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "cool",
		},
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "EdenEast/nightfox.nvim", name="nightfox", priority = 1000 }, -- lazy
}
