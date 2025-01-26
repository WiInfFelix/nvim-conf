return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "vtsls", "ruff" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local capa = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({ capabilities = capa })
      lspconfig.tsserver.setup({ capabilities = capa })
      lspconfig.ruff.setup({ capabilities = capa })

      vim.keymap.set("n", "<C-h>", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<C-d>", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {desc = "Show available code actions"})
    end,
  },
}
