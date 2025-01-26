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
    "oxfist/night-owl.nvim",
    name="night-owl",
    priority = 999,
    config = function ()
      require("night-owl").setup()
      vim.cmd("colorscheme night-owl")
    end
  }
}
