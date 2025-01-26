return {
  "mfussenegger/nvim-dap",

  config = function()
    local dap = require("dap")

    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {desc = "Toggle breakpoint on current line"})
    vim.keymap.set("n", "<leader>dc", dap.continue, {desc = "Step forward in debugger"})
  end
}
