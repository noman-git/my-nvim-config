return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
        "mfussenegger/nvim-dap-python",
        "leoluz/nvim-dap-go",
    },
    keys = {
        { "<F5>",  function() require("dap").continue() end,          desc = "Debug: start / continue" },
        { "<F10>", function() require("dap").step_over() end,         desc = "Debug: step over" },
        { "<F11>", function() require("dap").step_into() end,         desc = "Debug: step into" },
        { "<F12>", function() require("dap").step_out() end,          desc = "Debug: step out" },
        { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
        {
            "<leader>B",
            function()
                vim.ui.input({ prompt = "Breakpoint condition: " }, function(cond)
                    if cond and cond ~= "" then require("dap").set_breakpoint(cond) end
                end)
            end,
            desc = "Conditional breakpoint",
        },
        { "<leader>Dc", function() require("dap").continue() end,     desc = "Continue" },
        { "<leader>Du", function() require("dapui").toggle() end,     desc = "Toggle debug UI" },
        { "<leader>Dr", function() require("dap").repl.toggle() end,  desc = "Toggle REPL" },
        { "<leader>Dl", function() require("dap").run_last() end,     desc = "Run last configuration" },
        { "<leader>Dx", function() require("dap").terminate() end,    desc = "Terminate session" },
        { "<leader>DC", function() require("dap").clear_breakpoints() end, desc = "Clear all breakpoints" },
        {
            "<leader>De",
            function() require("dapui").eval(nil, { enter = true }) end,
            mode = { "n", "v" },
            desc = "Evaluate expression",
        },
        {
            "<leader>Dt",
            function()
                local ft = vim.bo.filetype
                if ft == "go" then
                    require("dap-go").debug_test()
                elseif ft == "python" then
                    require("dap-python").test_method()
                else
                    vim.notify("No test debugger for filetype " .. ft, vim.log.levels.WARN)
                end
            end,
            desc = "Debug nearest test",
        },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()
        require("nvim-dap-virtual-text").setup({})

        local debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
        if vim.uv.fs_stat(debugpy) then
            require("dap-python").setup(debugpy)
        end

        require("dap-go").setup({
            delve = {
                args = { "--check-go-version=false" },
            },
        })

        vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError", numhl = "" })
        vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticSignWarn", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticSignInfo", linehl = "Visual", numhl = "" })
        vim.fn.sign_define("DapLogPoint", { text = "◇", texthl = "DiagnosticSignHint", numhl = "" })

        dap.listeners.before.attach.dapui_config = function() dapui.open() end
        dap.listeners.before.launch.dapui_config = function() dapui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    end,
}
