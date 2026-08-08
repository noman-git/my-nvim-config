return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },

        indent = { enabled = true },

        notifier = { enabled = true, timeout = 3000 },

        quickfile = { enabled = true },

        statuscolumn = { enabled = true },

        words = { enabled = true },
    },
    keys = {
        { "]r", function() Snacks.words.jump(1, true) end, desc = "Next reference" },
        { "[r", function() Snacks.words.jump(-1, true) end, desc = "Previous reference" },
        { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification history" },
        { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },
    },
}
