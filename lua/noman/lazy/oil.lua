return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
            show_hidden = true,
        },
        keymaps = {
            ["q"] = { "actions.close", mode = "n" },
        },
    },
    keys = {
        { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
}
