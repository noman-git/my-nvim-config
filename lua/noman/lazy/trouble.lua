return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = false,
            })

            vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>",
                { desc = "Toggle Diagnostics" })
            vim.keymap.set("n", "<leader>tw", "<cmd>Trouble diagnostics toggle<cr>",
                { desc = "Toggle Workspace Diagnostics" })
            vim.keymap.set("n", "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                { desc = "Toggle Document Diagnostics" })
            vim.keymap.set("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>",
                { desc = "Toggle Quickfix" })

            vim.keymap.set("n", "[t", function()
                require("trouble").prev({ jump = true })
            end, { silent = true, desc = "Previous Trouble item" })

            vim.keymap.set("n", "]t", function()
                require("trouble").next({ jump = true })
            end, { silent = true, desc = "Next Trouble item" })
        end
    },
}
