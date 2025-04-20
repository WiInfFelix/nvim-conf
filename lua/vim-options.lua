vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.wrap = false

vim.g.mapleader = " "
vim.opt.number = true

-- Map Ctrl-s to save the file
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", {
	noremap = true,
	silent = true,
})
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR><Esc>", {
	noremap = true,
	silent = true,
})

vim.api.nvim_set_keymap("n", "<C-q>", ":bd<CR>", {
	noremap = true,
	silent = true,
})

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	float = {
		source = "always",
	},
})

-- vim.api.nvim_create_autocmd("CursorMoved", {
--	pattern = "*",
--	callback = function()
--		vim.diagnostic.open_float(nil, {
--			focusable = false,
--			scope = "cursor",
--		})
--	end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", {
		clear = true,
	}),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client.name == "ruff" then
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end
	end,
	desc = "LSP: Disable hover capability from Ruff",
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.keymap.set(
			"n",
			"<C-d>m",
			"<cmd>V/^\\s*def [a-zA-Z_]\\w*\\([^)]*\\):<CR>d",
			{ desc = "Delete until next python method", buffer = true }
		)
	end,
})

vim.keymap.set("v", "<leader>cf", vim.lsp.buf.format, { desc = "Format selection" })
vim.diagnostic.config({
	signs = { priority = 9999 },
	update_in_insert = false,
	underline = true,
	virtual_text = { current_line = true, severity = { min = "HINT", max = "WARN" } },
	virtual_lines = { current_line = true, severity = { min = "ERROR" } }, -- only since 0.11
	severity_sort = true,
})
