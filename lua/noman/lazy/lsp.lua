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

        require("fidget").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "ruff",
                "pyright",
                "gopls",
                "jsonls",
                "yamlls", },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.4" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })
        --Configure Pyright to defer to Ruff for linting and import organization
        require('lspconfig').pyright.setup {
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        ignore = { '*' },         -- Ignore Pyright's analysis to use Ruff for linting
                    },
                },
            },
            capabilities = capabilities,
        }

        -- Configure Ruff
        require('lspconfig').ruff.setup({
            init_options = {
                settings = {
                    settings = {
                        lint = {
                            select = { "F", "E", "W", "C", "N", "Q", "B", "D" }
                        }
                    }, -- Enable logging if needed
                },
            },
            capabilities = capabilities,
        })

        -- Mason-tool-installer setup for non-LSP tools
        require("mason-tool-installer").setup({
            ensure_installed = {
                "yapf",
                "pydocstyle",
            },
            auto_update = true,  -- Automatically update installed tools
            run_on_start = true, -- Ensure tools are installed when Neovim starts
        })


        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
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
