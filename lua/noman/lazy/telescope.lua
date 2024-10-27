return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = {
                    "venv/",
                    ".DS_Store",
                    "__pycache__/",
                    "*.pyc",
                    "*.pyo",
                    "node_modules/",
                    "*.egg-info/",
                    "*.jpg",
                    "*.jpeg",
                    "*.png",
                    "*.webp",
                    "*.mp4",
                    "*.mkv"
                    -- Add more patterns as needed
                }
            }
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fgf', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fcw', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>fcW', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
