return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        local harpoon = require("harpoon")

        -- Required on harpoon2: setup() is what installs the autocmds that keep
        -- list positions in sync as buffers change.
        harpoon:setup()

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end,
            { desc = "Add file to Harpoon" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Toggle Harpoon quick menu" })

        local nav_keys = { "<C-h>", "<C-t>", "<C-n>", "<C-s>" }
        for idx, key in ipairs(nav_keys) do
            vim.keymap.set("n", key, function() harpoon:list():select(idx) end,
                { desc = "Navigate to file " .. idx })
            -- replace_at with no item argument defaults to the current buffer, which
            -- is what the old harpoon1 mark.set_current_at did.
            vim.keymap.set("n", "<leader>" .. key, function() harpoon:list():replace_at(idx) end,
                { desc = "Set file " .. idx .. " in Harpoon" })
        end
    end
}
