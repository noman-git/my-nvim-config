return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    -- Declared as a lazy key rather than set inside config(), so it is bound from
    -- startup and loads conform on first use. Setting it in config() meant the old
    -- remap.lua binding stayed live until the first save.
    keys = {
        {
            "<leader>pf",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = { "n", "v" },
            desc = "Format buffer or selection",
        },
    },
    opts = {
        formatters_by_ft = {
            -- Go and Python are deliberately absent: lsp.lua already runs
            -- organize-imports-then-format through gopls and ruff on BufWritePre,
            -- and a second formatter on the same event would fight it.
            json = { "prettier" },
            jsonc = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            sh = { "shfmt" },
            bash = { "shfmt" },
        },
        format_on_save = {
            timeout_ms = 1000,
            -- Never fall back to an LSP formatter here. Anything not listed above
            -- is either handled by lsp.lua or intentionally left alone.
            lsp_format = "never",
        },
        formatters = {
            shfmt = {
                prepend_args = { "-i", "4" },
            },
        },
    },
}
