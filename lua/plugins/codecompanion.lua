local GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
local DEEPSEEK_API_KEY = os.getenv("DEEPSEEK_API_KEY")

local loaded_keys = {}
if GEMINI_API_KEY and GEMINI_API_KEY ~= "" then
	table.insert(loaded_keys, "Gemini")
end
if DEEPSEEK_API_KEY and DEEPSEEK_API_KEY ~= "" then
	table.insert(loaded_keys, "DeepSeek")
end

local message = "CodeCompanion API Keys Loaded: "
if #loaded_keys > 0 then
	message = message .. table.concat(loaded_keys, ", ")
else
	message = message .. "None"
end

vim.notify(message, vim.log.levels.INFO, { title = "CodeCompanion" })

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			display = {
				chat = {
					start_in_insert_mode = true,
					show_settings = true,
          auto_scroll = true,
				},
			},

			adapters = {
				deepseek = function()
					return require("codecompanion.adapters").extend("deepseek", {
						env = {
							api_key = DEEPSEEK_API_KEY,
						},
						model = {
							default = "deepseek-chat",
						},
					})
				end,
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						env = {
							api_key = GEMINI_API_KEY,
						},
						model = {
							default = "gemini-2.5-pro-exp-06-05",
						},
						temperature = {
							default = 0.7,
						},
					})
				end,
			},
			strategies = {
				chat = {
					adapter = "gemini",
					slash_commands = {
						["file"] = {
							callback = "strategies.chat.slash_commands.file",
							description = "Select a file using Snacks",
							opts = {
								provider = "snacks",
								contains_code = true,
							},
						},
					},
				},
			},
			prompt_library = {
				["Django + REST Expert"] = {
					strategy = "chat",
					description = [[You are an expert on modern Django 5.X and the newest version of the Django REST framework. You follow best practices for following the users desired input.
          You provide consice snippets of code with enough context for your provided solutions. After finishing the task consider if the user input follows best practice and if not provide an
          alternative approach.]],
				},
			},
			opts = {
				system_prompt = function(opts)
					return "You are a senior level software engineer. Assume I have knowledge of a mid level developer. You are tasked to assist me in a variety of coding tasks. If possible try to solve the task but also say if my idea is not best practice and suggest changes but only if they are realistically implementable. You dont have to show code for really basic things. Omit line numbers from your code but you can assume I can see them nonetheless."
				end,
			},
		})
	end,
	vim.api.nvim_set_keymap(
		"n",
		"<leader>ac",
		":CodeCompanionChat Toggle<CR>",
		{ desc = "Open CodeCompanionChat buffer" }
	),
	vim.api.nvim_set_keymap("n", "<leader>aa", ":CodeCompanionActions <CR>", { desc = "Show CodeCompanion actions" }),
	vim.api.nvim_set_keymap("v", "<leader>av", "<cmd>CodeCompanionChat Add<CR>", { desc = "Add selection to chat" }),
}
