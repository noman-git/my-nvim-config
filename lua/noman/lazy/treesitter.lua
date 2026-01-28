return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,  -- must load at startup
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")

        -- Essential parsers installed at startup (small wait to bootstrap)
        local essential_parsers = { "lua", "vim", "python" }
        ts.install(essential_parsers):wait(10000) -- wait max 10s

        -- List of parsers you might want to install on-demand
        local all_parsers = {
            "bash", "c", "go", "javascript", "json",
            "lua", "markdown", "markdown_inline", "python",
            "query", "vim", "vimdoc", "yaml",
        }

        -- Setup Treesitter features for a buffer
        local function setup_buffer(buf, lang)
            if not lang then return end

            -- Install parser non-blocking
            pcall(ts.install, { lang }, { summary = true })

            -- Start highlighting
            pcall(vim.treesitter.start, buf, lang)

            -- Indentation (buffer-local)
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

            -- Folding (window-local) → only if window exists
            -- local wins = vim.fn.win_findbuf(buf)
            -- for _, win in ipairs(wins) do
            --     vim.wo[win].foldmethod = "expr"
            --     vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            -- end

            -- Optional: regex highlighting for markdown
            if lang == "markdown" or lang == "markdown_inline" then
                vim.bo[buf].syntax = "enable"
            end
        end

        -- Autocmd for all buffers (opened normally or restored by auto-session)
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("ui.treesitter", { clear = true }),
            pattern = { "*" },
            callback = function(event)
                setup_buffer(event.buf, event.match)
            end,
        })

        -- Optional: preload all parsers asynchronously (no wait)
        for _, lang in ipairs(all_parsers) do
            if not vim.tbl_contains(essential_parsers, lang) then
                pcall(ts.install, { lang }, { summary = false })
            end
        end
    end
}

