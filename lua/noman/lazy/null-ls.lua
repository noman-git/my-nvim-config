return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
--                null_ls.builtins.formatting.yapf,
                require("none-ls.diagnostics.ruff"),
            },
        })
    end,
}

