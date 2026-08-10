return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "classic",
        spec = {
            { "<leader>a", group = "AI / Claude Code" },
            { "<leader>c", group = "Cloak / CSV" },
            { "<leader>D", group = "Debug" },
            { "<leader>q", group = "Database" },
            { "<leader>f", group = "Find" },
            { "<leader>g", group = "Git" },
            { "<leader>h", group = "Harpoon" },
            { "<leader>n", group = "Notifications" },
            { "<leader>p", group = "Python / format" },
            { "<leader>pv", group = "Python venv" },
            { "<leader>t", group = "Trouble" },
            { "<leader>v", group = "LSP / help" },
            { "<leader>w", group = "Sessions" },
            { "<leader>z", group = "Zen / LSP restart" },
            { "[", group = "Previous" },
            { "]", group = "Next" },
        },
    },
    keys = {
        {
            "<leader>?",
            function() require("which-key").show({ global = true }) end,
            desc = "Show all keymaps",
        },
    },
}
