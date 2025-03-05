vim.g.python3_host_prog = "/home/noman/.pyenv/versions/neovim/bin/python3"
vim.opt.guicursor = ""
vim.g.clipboard = {
    name = 'wl-clipboard',
    copy = { ['+'] = 'wl-copy', ['*'] = 'wl-copy' },
    paste = { ['+'] = 'wl-paste', ['*'] = 'wl-paste' },
    cache_enabled = 1,
}

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = false

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

