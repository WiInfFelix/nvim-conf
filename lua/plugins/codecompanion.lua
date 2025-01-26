DEEPSEEK_API_KEY = os.getenv("DEEPSEEK_API_KEY")

if DEEPSEEK_API_KEY ~= nil or DEEPSEEK_API_KEY ~= "" then
	return {
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				adapters = {
					deepseek = function() end,
				},
				strategies = {
					chat = {
						adapter = "deepseek",
					},
				},
			})
		end,
	}
else
	return {}
end
