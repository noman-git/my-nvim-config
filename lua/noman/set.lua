vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
if vim.fn.has("unix") == 1 and os.getenv("SSH_CONNECTION") then
  -- remote session: use lemonade
  vim.g.clipboard = {
    name = "lemonade",
    copy = { ["+"] = {"lemonade","copy"}, ["*"] = {"lemonade","copy"} },
    paste = { ["+"] = {"lemonade","paste"}, ["*"] = {"lemonade","paste"} },
    cache_enabled = 0,
  }
else
  -- local: use wl-clipboard
  vim.g.clipboard = {
    name = "wl-clipboard",
    copy = { ["+"] = {"wl-copy"}, ["*"] = {"wl-copy"} },
    paste = { ["+"] = {"wl-paste","--no-newline"}, ["*"] = {"wl-paste","--no-newline"} },
    cache_enabled = 1,
  }
end

vim.opt.guicursor = ""
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

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250

-- vim.opt.colorcolumn = "100"

