local on_attach = function(_, bufnr)
    -- format on save
    vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format()
        end
    })
end


local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_config = {
    capabilities = capabilities,
    group = vim.api.nvim_create_augroup('LspFormatting', { clear = true }),
    on_attach = function(_, bufnr)
        on_attach(_, bufnr)
    end
}

require('mason-lspconfig').setup_handlers({
    function(server_name)
        require('lspconfig')[server_name].setup(lsp_config)
    end,
    lua_ls = function()
        require('lspconfig').lua_ls.setup(vim.tbl_extend('force', lsp_config, {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        }))
    end,
    tsserver = function()
        require('typescript').setup({
            server = vim.tbl_extend('force', lsp_config, {
                on_attach = function(_, bufnr)
                    on_attach(_, bufnr)
                end,
                init_options = {
                    preferences = {
                        importModuleSpecifierPreference = 'project=relative',
                        jsxAttributeCompletionStyle = 'none'
                    }
                }
            })
        })
    end,
    pylsp = function()
        require('lspconfig').pylsp.setup(vim.tbl_extend('force', lsp_config, {
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = {
                            enabled = false, -- Disable pycodestyle if you prefer pylint's conventions
                        },
                        pyflakes = {
                            enabled = false, -- Optionally disable if you rely solely on pylint
                        },
                        pylint = {
                            enabled = true,
                            executable = "pylint", -- Ensure this matches your environment
                        },
                        mypy = {
                            enabled = true,
                            live_mode = false -- Run mypy on save, not as you type
                        },
                        -- Configure other pylsp plugins as needed
                    }
                }
            }
        }))
    end,
})


vim.keymap.set('n', '<leader>o', '<cmd>TypescriptOrganizeImports<cr>')
vim.keymap.set('n', '<leader>a', '<cmd>TypescriptAddMissingImports<cr>')
-- vim.keymap.set('n', '<leader>r', '<cmd>TypescriptRemoveUnused<cr>')
