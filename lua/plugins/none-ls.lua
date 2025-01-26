return {
	"nvimtools/none-ls.nvim",

	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
        -- lua 
				null_ls.builtins.formatting.stylua,

        -- python
				null_ls.builtins.formatting.blackd,

        -- js + frameworks
        null_ls.builtins.formatting.prettier
			},
		})

		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {desc = "Format current buffer with LSP"})
	end,
}
