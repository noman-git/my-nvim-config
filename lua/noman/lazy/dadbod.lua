return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function()
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.db_ui_show_database_icon = 1
        vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
        vim.g.db_ui_execute_on_save = 0
        vim.g.db_ui_win_position = "left"
        vim.g.db_ui_winwidth = 35
    end,
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("DadbodCmp", { clear = true }),
            pattern = { "sql", "mysql", "plsql" },
            callback = function()
                local ok, cmp = pcall(require, "cmp")
                if ok then
                    cmp.setup.buffer({
                        sources = cmp.config.sources(
                            { { name = "vim-dadbod-completion" } },
                            { { name = "buffer" } }
                        ),
                    })
                end
            end,
        })
    end,
    keys = {
        { "<leader>qq", "<cmd>DBUIToggle<cr>",        desc = "Toggle database UI" },
        { "<leader>qf", "<cmd>DBUIFindBuffer<cr>",    desc = "Find database buffer" },
        { "<leader>qa", "<cmd>DBUIAddConnection<cr>", desc = "Add database connection" },
    },
}
