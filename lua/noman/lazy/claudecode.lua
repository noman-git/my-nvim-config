return {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
        focus_after_send = true,
        diff_opts = {
            layout = "vertical",
            open_in_new_tab = true,
            hide_terminal_in_new_tab = false,
            keep_terminal_focus = false,
        },
        models = {
            { name = "Claude Opus 4.7 (Latest)",   value = "opus" },
            { name = "Claude Sonnet 4.6 (Latest)", value = "sonnet" },
            { name = "Claude Haiku 4.5 (Latest)",  value = "haiku" },
        },
    },
    keys = {
        { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
        { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
        { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
        { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
        { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                   desc = "Send to Claude" },
        {
            "<leader>as",
            "<cmd>ClaudeCodeTreeAdd<cr>",
            desc = "Add file",
            ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
        },
        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr><cmd>ClaudeCodeFocus<cr>", desc = "Accept diff" },
        { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr><cmd>ClaudeCodeFocus<cr>",   desc = "Deny diff" },
    },
}
