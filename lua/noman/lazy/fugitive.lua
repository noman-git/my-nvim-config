return {
    "tpope/vim-fugitive",
    config = function()
        -- Global keymap for staging all changes
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>ga", function()
            vim.cmd.Git("add .")
        end)

        local Noman_Fugitive = vim.api.nvim_create_augroup("Noman_Fugitive", {})

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = Noman_Fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = {buffer = bufnr, remap = false}

                -- Buffer-local keymap for staging the current file
                vim.keymap.set("n", "<leader>ga", function()
                    vim.cmd.Git('add %')  -- Adds the current file
                end, opts)

                vim.keymap.set("n", "<leader>gc", function()
                    vim.cmd.Git('commit')  -- Adds the current file
                end, opts)

                -- Other fugitive buffer keymaps (e.g., git push, pull)
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, opts)
                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git({'pull', '--rebase'})
                end, opts)
                vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
            end,
        })

        -- Keymaps for merge conflict resolution
        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end
}

