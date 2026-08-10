return {
    "hat0uma/csvview.nvim",
    ft = { "csv", "tsv" },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    opts = {
        parser = {
            comments = { "#", "//" },
        },
        view = {
            display_mode = "border",
            header_lnum = 1,
        },
    },
    keys = {
        { "<leader>cv", "<cmd>CsvViewToggle<cr>", desc = "Toggle CSV table view" },
    },
}
