return {
  "GCBallesteros/NotebookNavigator.nvim",
  keys = {
    { "]h", function() require("notebook-navigator").move_cell "d" end, desc = "Move to next cell" },
    { "[h", function() require("notebook-navigator").move_cell "u" end, desc = "Move to previous cell" },
    { "<leader>X", function() require("notebook-navigator").run_cell() end, desc = "Run current cell" },
    { "<leader>x", function() require("notebook-navigator").run_and_move() end, desc = "Run cell and move" },
  },
  dependencies = {
    "echasnovski/mini.comment",
    "anuvyklack/hydra.nvim",
    "vigemus/iron.nvim", -- Use Magma as REPL provider
  },
  event = "VeryLazy",
  config = function()
    require("notebook-navigator").setup({
      activate_hydra_keys = "<leader>hk", -- Activate Hydra with <leader>h
      repl_provider = "iron",
    })
  end,
}

