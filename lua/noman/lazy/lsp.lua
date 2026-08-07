return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "j-hui/fidget.nvim",
    },

    config = function()
        require("mason").setup()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        -- Applies to every server. mason-lspconfig v2 dropped the `handlers` option,
        -- so this is how the old default handler's capabilities get restored.
        vim.lsp.config("*", { capabilities = capabilities })

        require("fidget").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "ruff", "basedpyright", "jsonls", "yamlls", "gopls" },
        })

        -- Point the type checker at the project's own interpreter. Without this it
        -- falls back to `python` on PATH, which here is the pyenv global shim, and
        -- every venv-only import reads as unresolved. Bounded by root_dir so a
        -- subproject never binds to a venv sitting above its own root.
        local function venv_python(_, config)
            local root = config.root_dir
            local buf_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
            local start = (buf_dir ~= "" and buf_dir) or root
            if not start then
                return
            end
            local found = vim.fs.find({ ".venv", "venv" }, {
                upward = true,
                type = "directory",
                path = start,
                -- Walk up as far as the project root, inclusive. With no root markers
                -- at all there is no project, so look only in the file's own directory
                -- rather than wandering up and grabbing an unrelated venv.
                stop = vim.fs.dirname(root or start),
            })
            for _, dir in ipairs(found) do
                local py = dir .. "/bin/python"
                if vim.uv.fs_stat(py) then
                    config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
                        python = { pythonPath = py },
                    })
                    return
                end
            end
        end

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = { version = "Lua 5.4" },
                    diagnostics = {
                        globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
        })

        -- basedpyright defers to Ruff for imports. No on_attach here on purpose:
        -- lspconfig's own basedpyright config registers :LspPyrightSetPythonPath and
        -- :LspPyrightOrganizeImports through one, and vim.lsp.config replaces
        -- functions rather than merging them, so defining ours would drop both.
        vim.lsp.config("basedpyright", {
            before_init = venv_python,
            settings = {
                basedpyright = {
                    disableOrganizeImports = true,
                    analysis = {
                        -- basedpyright defaults to "recommended", which turns on every
                        -- rule. "standard" keeps the noise where pyright had it.
                        typeCheckingMode = "standard",
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "openFilesOnly",
                        inlayHints = {
                            variableTypes = true,
                            callArgumentNames = true,
                            functionReturnTypes = true,
                            genericTypes = true,
                        },
                    },
                },
            },
        })

        vim.lsp.config("ruff", {
            init_options = {
                settings = {
                    organizeImports = true,
                    showSyntaxErrors = true,
                    codeAction = {
                        disableRuleComment = { enable = false },
                    },
                    lint = {
                        select = { "F", "E", "W", "C", "N", "Q", "B", "I", "UP" },
                    },
                },
            },
        })

        vim.lsp.config("gopls", {
            settings = {
                gopls = {
                    gofumpt = true,
                    staticcheck = true,
                    usePlaceholders = true,
                    completeUnimported = true,
                    analyses = {
                        unusedparams = true,
                        unusedwrite = true,
                        nilness = true,
                        shadow = true,
                        useany = true,
                    },
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                },
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                },
                {
                    { name = 'buffer' },
                })
        })

        -- Organize imports, then format, both through one named client. gopls does
        -- this for Go and ruff for Python; keeping them on one helper means the two
        -- can never end up formatting through each other.
        local function organize_and_format(bufnr, client_name)
            local params = vim.lsp.util.make_range_params(0, "utf-8")
            -- `diagnostics` is required by the spec. gopls tolerates it missing,
            -- ruff rejects the whole request with a parse error.
            params.context = { only = { "source.organizeImports" }, diagnostics = {} }
            local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 2000)
            for cid, res in pairs(results or {}) do
                local client = vim.lsp.get_client_by_id(cid)
                if client and client.name == client_name then
                    for _, action in pairs(res.result or {}) do
                        if not action.edit and action.data then
                            local resolved = client:request_sync("codeAction/resolve", action, 2000, bufnr)
                            action = (resolved or {}).result or action
                        end
                        if action.edit then
                            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
                        elseif action.command then
                            client:exec_cmd(action.command, { bufnr = bufnr })
                        end
                    end
                end
            end
            vim.lsp.buf.format({
                bufnr = bufnr,
                async = false,
                filter = function(c) return c.name == client_name end,
            })
        end

        local fmt_group = vim.api.nvim_create_augroup("LspOrganizeAndFormat", { clear = true })
        for pattern, client_name in pairs({ ["*.go"] = "gopls", ["*.py"] = "ruff" }) do
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = fmt_group,
                pattern = pattern,
                callback = function(ev)
                    organize_and_format(ev.buf, client_name)
                end,
            })
        end

        vim.diagnostic.config({
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
