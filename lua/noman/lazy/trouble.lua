return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = false,
            })

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle()
            end)

            vim.keymap.set("n", "[t", function()
                require("trouble").next({skip_groups = true, jump = true});
            end)

            vim.keymap.set("n", "]t", function()
                require("trouble").previous({skip_groups = true, jump = true});
            end)
            vim.keymap.set("n", "<leader>tw", function()
                require("trouble").toggle("workspace_diagnostics") end, { desc = "Toggle Workspace Diagnostics" })

            vim.keymap.set("n", "<leader>td", function()
                require("trouble").toggle("document_diagnostics") end, { desc = "Toggle Document Diagnostics" })

            vim.keymap.set("n", "<leader>tq", function()
                require("trouble").toggle("quickfix") end, { desc = "Toggle Quickfix" })
        end
    },
}
