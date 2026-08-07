My personal neovim config.

Requires Neovim 0.12 or newer.

Prerequisites: npm, ripgrep, lua.

Image rendering in markdown needs the ImageMagick CLI (the `magick` binary) and a
terminal that speaks the kitty graphics protocol. Luarocks is no longer needed.

The python provider expects a virtualenv named `neovim` at `~/.virtualenvs/neovim`
with `pynvim` installed. Set via `vim.g.python3_host_prog` in `lua/noman/set.lua`;
change that path if your interpreter lives elsewhere.

    python3 -m venv ~/.virtualenvs/neovim
    ~/.virtualenvs/neovim/bin/pip install pynvim
