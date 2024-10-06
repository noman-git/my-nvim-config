return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all"
            ensure_installed = {
                "vimdoc", "javascript", "typescript", "c", "lua",
                "jsdoc", "bash", "python", "go",
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            auto_install = true,

            -- Enable indentation based on Tree-sitter
            indent = {
                enable = true
            },

            -- Enable syntax highlighting
            highlight = {
                enable = true,
                -- You can enable additional Vim regex highlighting for markdown files here
                additional_vim_regex_highlighting = { "markdown" },
            },
        })
    end
}

