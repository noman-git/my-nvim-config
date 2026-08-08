return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end,
            { desc = "Add file to Harpoon" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Toggle Harpoon quick menu" })

        local nav_keys = { "<C-h>", "<C-t>", "<C-n>", "<C-s>" }
        for idx, key in ipairs(nav_keys) do
            vim.keymap.set("n", key, function() harpoon:list():select(idx) end,
                { desc = "Navigate to file " .. idx })
            vim.keymap.set("n", "<leader>" .. key, function() harpoon:list():replace_at(idx) end,
                { desc = "Set file " .. idx .. " in Harpoon" })
        end
    end
}
