return {
  "bassamsdata/namu.nvim",
  config = function()
    require("namu").setup({
      -- Enable the modules you want
      namu_symbols = {
        enable = true,
        options = {}, -- here you can configure namu
      },
      -- Optional: Enable other modules if needed
      ui_select = { enable = false }, -- vim.ui.select() wrapper
      colorscheme = {
        enable = true,
        options = {
          -- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
          persist = true, -- very efficient mechanism to Remember selected colorscheme
          write_shada = true, -- If you open multiple nvim instances, then probably you need to enable this
        },
      },
    })
    -- === Suggested Keymaps: ===
    vim.keymap.set("n", "<leader>ss",":Namu symbols<cr>" , {
      desc = "Jump to LSP symbol",
      silent = true,
    })
    vim.keymap.set("n", "<leader>th", ":Namu colorscheme<cr>", {
      desc = "Colorscheme Picker",
      silent = true,
    })
    vim.keymap.set("n", "<leader>cs", "<cmd>:Namu symbols<CR>", { desc = "Show buffer symbols"})
  end,
}
