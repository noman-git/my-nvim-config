vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>k0zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>pf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("v", "<leader>s", ":'<,'>s/\\%V<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Horizontal split
vim.keymap.set('n', '<leader>sh', '<C-w>s', { noremap = true, silent = true })
-- Vertical split
vim.keymap.set('n', '<leader>sv', '<C-w>v', { noremap = true, silent = true })

-- Close current split
vim.keymap.set('n', '<leader>sc', '<C-w>c', { noremap = true, silent = true })
-- Close all except current
vim.keymap.set('n', '<leader>so', '<C-w>o', { noremap = true, silent = true })

-- Zoom in on current split (maximize)
vim.keymap.set('n', 'Zz', '<C-w>_ | <C-w>|', { noremap = true, silent = true })

-- Restore all splits to equal size
vim.keymap.set('n', 'Zo', '<C-w>=', { noremap = true, silent = true })

-- This is for creating a python env with name venv and default global version
vim.keymap.set("n", "<leader>pvc", ":!python3 -m venv venv<CR>",
    { desc = "Create virtual environment in current directory" })

-- This is for activating my venv
vim.keymap.set('n', '<leader>pva', function()
    vim.cmd('!source venv/bin/activate')
end, { desc = "Activate virtual env" })

vim.keymap.set( "n", "<leader>pe", ":!python3 %<CR>")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
