return {
    "lervag/vimtex",
    lazy = false,
    init = function()
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_compiler_latexmk = {
            continuous = 1,
            options = {
                "-shell-escape",
                "-verbose",
                "-file-line-error",
                "-synctex=1",
                "-interaction=nonstopmode",
            },
        }

        if vim.fn.executable("zathura") == 1 then
            vim.g.vimtex_view_method = "zathura"
        else
            vim.g.vimtex_view_method = "general"
            vim.g.vimtex_view_general_viewer = "xdg-open"
            vim.g.vimtex_view_general_options = "@pdf"
        end

        vim.g.vimtex_syntax_enabled = 0
        vim.g.vimtex_quickfix_mode = 0
        vim.g.vimtex_quickfix_open_on_warning = 0
        vim.g.vimtex_indent_enabled = 1
        vim.g.vimtex_fold_enabled = 0
    end,
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("VimtexKeys", { clear = true }),
            pattern = { "tex", "plaintex", "bib" },
            callback = function(e)
                local maps = {
                    ll = { "<cmd>VimtexCompile<cr>",   "LaTeX compile (toggle continuous)" },
                    lv = { "<cmd>VimtexView<cr>",      "LaTeX view PDF" },
                    lk = { "<cmd>VimtexStop<cr>",      "LaTeX stop compilation" },
                    lc = { "<cmd>VimtexClean<cr>",     "LaTeX clean aux files" },
                    le = { "<cmd>VimtexErrors<cr>",    "LaTeX errors" },
                    lt = { "<cmd>VimtexTocToggle<cr>", "LaTeX table of contents" },
                    li = { "<cmd>VimtexInfo<cr>",      "LaTeX info" },
                }
                for lhs, spec in pairs(maps) do
                    vim.keymap.set("n", "<leader>" .. lhs, spec[1],
                        { buffer = e.buf, desc = spec[2] })
                end
            end,
        })
    end,
}
