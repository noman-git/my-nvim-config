vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fe", "<cmd>Oil<cr>", { desc = "File explorer (oil)" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over without yanking" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- Global, not set on LspAttach: a buffer-local map only exists once the server
-- has attached, and until then the builtins run silently. Builtin gd is a lexical
-- search of the current file, so on `pkg.Router(...)` it jumps to any `Router` in
-- the same file; builtin K opens a man page. Both look like real answers.
-- Will a server eventually attach to this buffer? Lets us wait for a slow start
-- on go/python/lua while keeping the builtin instant everywhere else.
local function server_expected(bufnr)
    local ok, configs = pcall(function() return vim.lsp.config._configs end)
    if not ok or type(configs) ~= "table" then
        return false
    end
    local ft = vim.bo[bufnr].filetype
    for name in pairs(configs) do
        if name ~= "*" and vim.lsp.is_enabled(name) then
            local cfg = vim.lsp.config[name]
            if cfg and vim.tbl_contains(cfg.filetypes or {}, ft) then
                return true
            end
        end
    end
    return false
end

local function lsp_or(method, lsp_fn, fallback)
    return function()
        local function ready()
            return #vim.lsp.get_clients({ bufnr = 0, method = method }) > 0
        end
        local expected = server_expected(0)
        if not ready() and expected then
            vim.wait(2000, ready, 50)
        end
        if ready() then
            lsp_fn()
        elseif expected then
            -- Staying put beats the builtin's lexical guess, which reads as a real answer
            vim.notify("LSP not ready for this buffer, not jumping", vim.log.levels.WARN)
        else
            fallback()
        end
    end
end

vim.keymap.set("n", "gd", lsp_or("textDocument/definition", vim.lsp.buf.definition,
    function() vim.cmd("normal! gd") end), { desc = "Goto definition" })
vim.keymap.set("n", "K", lsp_or("textDocument/hover", vim.lsp.buf.hover,
    function() vim.cmd("normal! K") end), { desc = "Hover" })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown preview" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next loclist item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous loclist item" })

vim.keymap.set("v", "<leader>s", ":'<,'>s/\\%V<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word in selection" })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word in file" })

-- Zoom in on current split (maximize)
vim.keymap.set('n', 'Zz', '<C-w>_ | <C-w>|', { noremap = true, silent = true, desc = 'Maximize split' })

-- Restore all splits to equal size
vim.keymap.set('n', 'Zo', '<C-w>=', { noremap = true, silent = true, desc = 'Equalize splits' })

-- This is for creating a python env with name .venv and default global version
vim.keymap.set("n", "<leader>pvc", ":!python3 -m venv .venv<CR>",
    { desc = "Create virtual environment in current directory" })

-- The LSP picks up .venv/ automatically on attach; this re-points it after
-- creating a venv mid-session, or at an interpreter living outside the project.
vim.keymap.set('n', '<leader>pva', function()
    local root = vim.fs.root(0, { "pyproject.toml", "setup.py", ".git" }) or vim.fn.getcwd()
    local py = root .. "/.venv/bin/python"
    if vim.uv.fs_stat(py) then
        vim.cmd("LspPyrightSetPythonPath " .. py)
    else
        vim.ui.input({ prompt = "python path: ", default = root .. "/", completion = "file" },
            function(input)
                if input then vim.cmd("LspPyrightSetPythonPath " .. input) end
            end)
    end
end, { desc = "Point the LSP at a virtual env" })

vim.keymap.set("n", "<leader>pe", ":!python3 %<CR>", { desc = "Run file with python3" })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "Source current file" })

-- Terminal mode: double-Esc to drop into normal mode (single Esc still reaches the TUI)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
