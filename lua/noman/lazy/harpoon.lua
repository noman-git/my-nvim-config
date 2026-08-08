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
            { desc = "Pin file to Harpoon" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Toggle Harpoon quick menu" })

        for idx = 1, 4 do
            vim.keymap.set("n", "<M-" .. idx .. ">", function() harpoon:list():select(idx) end,
                { desc = "Harpoon jump to " .. idx })
            vim.keymap.set("n", "<leader>h" .. idx, function() harpoon:list():replace_at(idx) end,
                { desc = "Harpoon set slot " .. idx })
        end

        vim.keymap.set("n", "<M-]>", function() harpoon:list():next() end,
            { desc = "Harpoon next" })
        vim.keymap.set("n", "<M-[>", function() harpoon:list():prev() end,
            { desc = "Harpoon previous" })
    end
}
