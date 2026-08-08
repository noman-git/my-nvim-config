return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        current_line_blame = true,
        current_line_blame_opts = {
            delay = 400,
            virt_text_pos = "eol",
        },
        on_attach = function(bufnr)
            local gs = require("gitsigns")

            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            -- nav_hunk, not the deprecated next_hunk/prev_hunk pair.
            map("n", "]h", function() gs.nav_hunk("next") end, "Next git hunk")
            map("n", "[h", function() gs.nav_hunk("prev") end, "Previous git hunk")

            -- <leader>gs and <leader>ga belong to fugitive; these fill in the
            -- hunk-level operations fugitive makes awkward.
            map("n", "<leader>gh", gs.stage_hunk, "Stage hunk (toggles)")
            map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
            map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
            map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
            map("n", "<leader>gd", gs.diffthis, "Diff against index")

            -- Stage or reset just the selected lines rather than the whole hunk.
            map("v", "<leader>gh", function()
                gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Stage selected lines")
            map("v", "<leader>gr", function()
                gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Reset selected lines")

            -- Hunk text object, so dih / vih work on a change.
            map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
        end,
    },
}
