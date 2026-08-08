require("noman.set")
require("noman.remap")
require("noman.lazy_init")

-- DO.not
-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

-- DO NOT INCLUDE THIS
-- DO.not

local augroup = vim.api.nvim_create_augroup
local TheNomanGroup = augroup('TheNoman', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.hl.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = TheNomanGroup,
    pattern = "*",
    callback = function()
        local view = vim.fn.winsaveview()
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
})

autocmd('LspAttach', {
    group = TheNomanGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        -- gd and K are defined globally in remap.lua, not here. Defining them on
        -- attach leaves a window where the builtins run instead: builtin gd is a
        -- lexical "local declaration" search that happily lands on an unrelated
        -- same-named symbol in the current file, and says nothing about it.
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
            vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end,
            vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
            vim.tbl_extend("force", opts, { desc = "Code action" }))
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
            vim.tbl_extend("force", opts, { desc = "References" }))
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end,
            vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
            vim.tbl_extend("force", opts, { desc = "Signature help" }))
        -- No [d/]d here: nvim ships them (plus [D/]D for first/last) built on
        -- vim.diagnostic.jump, pointing the right way round. Overriding them only
        -- reintroduced the inverted, deprecated goto_prev/goto_next pair.

        local client = vim.lsp.get_client_by_id(e.data.client_id)
        if client and client.name == "ruff" then
            -- K should give a type signature from basedpyright, not a ruff rule blurb
            client.server_capabilities.hoverProvider = false
        end
        if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = e.buf })
            vim.keymap.set("n", "<leader>vi", function()
                local on = vim.lsp.inlay_hint.is_enabled({ bufnr = e.buf })
                vim.lsp.inlay_hint.enable(not on, { bufnr = e.buf })
            end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
        end
    end
})
