return {
    "ThePrimeagen/harpoon",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        local harpoon = require("harpoon")
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        -- Setup Harpoon
        harpoon.setup()

        -- Key mappings for Harpoon
        vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to Harpoon" })
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle Harpoon quick menu" })

        vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = "Navigate to file 1" })
        vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end, { desc = "Navigate to file 2" })
        vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end, { desc = "Navigate to file 3" })
        vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end, { desc = "Navigate to file 4" })

        vim.keymap.set("n", "<leader><C-h>", function() harpoon.mark.set_index(1) end, { desc = "Set file 1 in Harpoon" })
        vim.keymap.set("n", "<leader><C-t>", function() harpoon.mark.set_index(2) end, { desc = "Set file 2 in Harpoon" })
        vim.keymap.set("n", "<leader><C-n>", function() harpoon.mark.set_index(3) end, { desc = "Set file 3 in Harpoon" })
        vim.keymap.set("n", "<leader><C-s>", function() harpoon.mark.set_index(4) end, { desc = "Set file 4 in Harpoon" })
    end
}

