return {
  "sindrets/diffview.nvim",

  config = function()
    local actions = require("diffview.actions")

    keymaps = {
      { "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll the view" } },
    }
  end,
}
