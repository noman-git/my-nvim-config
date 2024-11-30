return {
  "echasnovski/mini.hipatterns",
  event = "VeryLazy",
  dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
  opts = function()
    local nn = require "notebook-navigator"
    return { highlighters = { cells = nn.minihipatterns_spec } }
  end,
}

