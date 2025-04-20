return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.after.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			vim.keymap.set(
				"n",
				"<leader>dt",
				"<cmd> DapToggleBreakpoint <CR>",
				{ desc = "Toggle breakpoint on current line" }
			)
			vim.keymap.set("n", "<leader>ds", "<cmd> DapContinue <CR>", { desc = "Start debugger by choosing config" })
			vim.keymap.set("n", "<A-s>", "<cmd> DapStepOver <CR>", { desc = "DEBUG: Step over" })
			vim.keymap.set("n", "<A-i>", "<cmd> DapStepInto <CR>", { desc = "DEBUG: Step over" })
			vim.keymap.set("n", "<A-o>", "<cmd> DapStepOut <CR>", { desc = "DEBUG: Step over" })
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function(_, opts)
			require("dapui").setup()
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"

			local dap = require("dap")
			dap.configurations.python = {
				{
					name = "Django",
					type = "python",
					request = "launch",
					program = "${workspaceFolder}/manage.py",
					args = { "runserver", "0.0.0.0:8000" },
					django = true,
					justMyCode = false,
				},
			}

			require("dap-python").setup(path)
			vim.keymap.set("n", "<leader>dr", require("dap-python").test_method, { desc = "Run python debugger" })
		end,
	},
}
