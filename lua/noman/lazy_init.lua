local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "noman.lazy",
    change_detection = { notify = false },
    -- Nothing here needs a luarock any more: image.nvim runs the magick_cli
    -- processor. Leaving this on made checkhealth demand a hererocks-built
    -- luarocks binary that no longer gets installed.
    rocks = { enabled = false },
})
