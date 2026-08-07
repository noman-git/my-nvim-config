return {
    "nvim-telescope/telescope.nvim",

    tag = "v0.2.2",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')

    -- Smart send to quickfix
    local function smart_send_to_qflist(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local selections = picker:get_multi_selection()

        if #selections > 0 then
            -- Send only selected entries
            actions.send_selected_to_qflist(prompt_bufnr)
        else
            -- Send all entries
            actions.send_to_qflist(prompt_bufnr)
        end
        actions.open_qflist(prompt_bufnr)
    end

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
                },
                mappings = {
                    i = {
                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
                        ["<C-q>"] = smart_send_to_qflist,
                    },
                    n = {
                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
                        ["<C-q>"] = smart_send_to_qflist,
                    },
                },
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
