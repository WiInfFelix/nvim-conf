return {
	"goolord/alpha-nvim",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.startify")

		dashboard.section.header.val = {
			"Ducunt volentem fatam, nolentem trahunt...",
		}

		alpha.setup(dashboard.opts)
	end,
}
