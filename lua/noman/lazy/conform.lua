return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
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
            lsp_format = "never",
        },
        formatters = {
            shfmt = {
                prepend_args = { "-i", "4" },
            },
        },
    },
}
