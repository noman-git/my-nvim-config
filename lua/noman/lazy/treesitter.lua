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
            "bash", "c", "go", "gomod", "gosum", "gotmpl", "gowork",
            "javascript", "json", "lua", "markdown", "markdown_inline",
            "python", "query", "vim", "vimdoc", "yaml",
        }

        -- Parsers this nvim-treesitter build actually knows about. Asking it to
        -- install anything outside this set logs "skipping unsupported language",
        -- which every plugin UI buffer (fidget, qf, netrw, lazy, telescope...) would
        -- otherwise trigger on each FileType event.
        local available = {}
        for _, parser in ipairs(ts.get_available()) do
            available[parser] = true
        end

        local no_ts_indent = { python = true }

        -- Built-in python indent puts continuation lines inside open brackets at
        -- 2 * shiftwidth by default; PEP 8 style is one level.
        vim.g.python_indent = {
            open_paren = "shiftwidth()",
            nested_paren = "shiftwidth()",
            continue = "shiftwidth()",
            closed_paren_align_last_line = false,
        }

        -- Setup Treesitter features for a buffer
        local function setup_buffer(buf, ft)
            if not ft or ft == "" then return end

            -- Filetype is not the parser name: help -> vimdoc, sh -> bash, tex -> latex.
            -- Passing the raw filetype meant those buffers got no highlighting at all.
            local lang = vim.treesitter.language.get_lang(ft) or ft
            if not available[lang] then return end

            -- Install parser non-blocking
            pcall(ts.install, { lang }, { summary = true })

            -- Start highlighting
            pcall(vim.treesitter.start, buf, lang)

            -- Indentation (buffer-local). Python keeps nvim's built-in indent: the
            -- treesitter one reads a half-typed line (missing ':') as an ERROR node
            -- and indents every line after it wrong.
            if not no_ts_indent[lang] then
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end

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

