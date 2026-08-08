-- snacks.nvim was already on disk as a claudecode.nvim dependency. This spec just
-- turns on the modules worth having; lazy merges it with claudecode's declaration.
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        -- Disables treesitter, LSP and other heavy features on very large files so
        -- opening a big log or data dump does not hang.
        bigfile = { enabled = true },

        -- Indent guides plus highlighting for the scope the cursor sits in.
        indent = { enabled = true },

        -- Replaces vim.notify with something readable and non-blocking. remap.lua's
        -- "LSP not ready" warning routes through this.
        notifier = { enabled = true, timeout = 3000 },

        -- Renders the file before plugins finish loading, so `nvim somefile` shows
        -- text immediately instead of an empty buffer.
        quickfile = { enabled = true },

        -- Merges signs, numbers and git marks into one tidy column. This is why
        -- signcolumn stays at "yes" rather than needing "yes:2": git signs and
        -- diagnostics no longer compete for the same slot.
        statuscolumn = { enabled = true },

        -- Highlights every other reference to the symbol under the cursor.
        words = { enabled = true },
    },
    keys = {
        -- snacks.words ships no keymaps of its own. ]r / [r rather than ]] / [[,
        -- which Neovim already uses for LSP class motions.
        { "]r", function() Snacks.words.jump(1, true) end, desc = "Next reference" },
        { "[r", function() Snacks.words.jump(-1, true) end, desc = "Previous reference" },
        { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification history" },
        { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },
    },
}
