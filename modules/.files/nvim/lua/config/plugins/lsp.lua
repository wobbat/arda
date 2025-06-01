-- in your plugins.lua (or wherever you call require('lazy').setup)
return {
    -- 1) Mason installer
    {
        'williamboman/mason.nvim',
        lazy = false, -- load at startup so `require('mason')` is available
        build = ':MasonUpdate',
    },

    -- 2) Bridge Mason → lspconfig
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim' },
    },

    -- 3) blink.cmp for ultra-fast fuzzy completion
    {
        'saghen/blink.cmp',
        version      = '1.*',
        dependencies = { 'rafamadriz/friendly-snippets' },
        opts         = {
            keymap     = { preset = 'default' },
            appearance = { nerd_font_variant = 'mono' },
            completion = { documentation = { auto_show = false } },
            sources    = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
            fuzzy      = { implementation = 'prefer_rust_with_warning' },
        },
    },

    -- 4) Lua-Dev for enhanced Lua LSP
    { 'folke/lua-dev.nvim', ft = 'lua' },

    -- 5) nvim-lspconfig with Mason, blink.cmp & lua-dev integration
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'saghen/blink.cmp',
            'folke/lua-dev.nvim',
        },
        config = function()
            -- bootstrap Mason
            require('mason').setup()

            -- shared on_attach: keymaps + format-on-save
            local on_attach = function(client, bufnr)
                local function buf_map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
                end

                -- navigation & actions
                buf_map('n', 'gd', vim.lsp.buf.definition, 'LSP: Go to Definition')
                buf_map('n', 'gD', vim.lsp.buf.declaration, 'LSP: Go to Declaration')
                buf_map('n', 'gi', vim.lsp.buf.implementation, 'LSP: Go to Implementation')
                buf_map('n', 'gr', vim.lsp.buf.references, 'LSP: Show References')
                buf_map('n', 'K', vim.lsp.buf.hover, 'LSP: Hover Documentation')
                buf_map('n', '<leader>rn', vim.lsp.buf.rename, 'LSP: Rename Symbol')
                buf_map('n', '<leader>ca', vim.lsp.buf.code_action, 'LSP: Code Action')
                buf_map('n', '<leader>sd', vim.diagnostic.open_float, 'LSP: Show Diagnostics')
                buf_map('n', '[d', vim.diagnostic.goto_prev, 'LSP: Prev Diagnostic')
                buf_map('n', ']d', vim.diagnostic.goto_next, 'LSP: Next Diagnostic')

                -- manual format
                -- buf_map('n', '<leader>`', function() vim.lsp.buf.format { async = true } end, 'LSP: Format Buffer')

                -- auto-format on save
                if client.server_capabilities.documentFormattingProvider then
                    local group = vim.api.nvim_create_augroup('LspFormat' .. bufnr, { clear = true })
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group    = group,
                        buffer   = bufnr,
                        callback = function() vim.lsp.buf.format { async = false } end,
                    })
                end
            end

            -- Blink’s enhanced LSP capabilities
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- Mason-LSPConfig v2: ensure & handler table
            require('mason-lspconfig').setup {
                ensure_installed = { 'lua_ls', 'pyright', 'rust_analyzer', 'gopls', 'ocamllsp' },
                automatic_installation = true, -- install if missing
                handlers = {
                    -- default handler for all servers except lua_ls
                    function(server_name)
                        require('lspconfig')[server_name].setup {
                            on_attach    = on_attach,
                            capabilities = capabilities,
                        }
                    end,
                    -- override for lua_ls using lua-dev
                    lua_ls = function()
                        local luadev_opts = require('lua-dev').setup {
                            lspconfig = {
                                on_attach    = on_attach,
                                capabilities = capabilities,
                                settings     = {
                                    Lua = {
                                        runtime = {
                                            version = "LuaJIT", -- tell the server which Lua version
                                        },
                                        diagnostics = {
                                            -- tell the server that `vim` is a defined global
                                            globals = { "vim" },
                                        },
                                        workspace = {
                                            -- make the server aware of Neovim runtime files
                                            library = vim.api.nvim_get_runtime_file("", true),
                                            checkThirdParty = false, -- suppress prompt for checking third-party libs
                                        },
                                    },
                                },
                            },
                        }
                        require("lspconfig").lua_ls.setup(luadev_opts)
                    end,
                },
            }
        end,
    },
}
