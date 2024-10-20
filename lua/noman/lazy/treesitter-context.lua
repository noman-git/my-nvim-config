return {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
        "nvim-treesitter/nvim-treesitter", -- Ensure Treesitter is loaded
    },
    config = function()
        require("treesitter-context").setup({
            enable = true, -- Enable this plugin
            max_lines = 0, -- No limit on how many lines the window should span
            min_window_height = 0, -- No limit on minimum editor window height to enable context
            line_numbers = true, -- Show line numbers in the context
            multiline_threshold = 20, -- Max number of lines for a single context
            trim_scope = 'outer', -- Discard outer lines if max_lines is exceeded
            mode = 'cursor', -- Use the cursor line to calculate context
            separator = nil, -- No separator between context and content by default
            zindex = 20, -- Set the Z-index of the context window
            on_attach = nil, -- No custom function on attach
        })

        -- Highlight customization (optional)
        vim.cmd([[
            hi TreesitterContextBottom gui=underline guisp=Grey
            hi TreesitterContextLineNumberBottom gui=underline guisp=Grey
        ]])

        -- Keybinding to jump to the context upwards
        vim.keymap.set("n", "[c", function()
            require("treesitter-context").go_to_context(vim.v.count1)
        end, { silent = true })
    end,
}

