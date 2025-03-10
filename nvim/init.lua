-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.updatetime = 50
vim.opt.clipboard:append('unnamedplus')

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 300
        })
    end
})

-- Key mappings (keeping the most useful ones)
vim.g.mapleader = ' '
local keymap = vim.keymap

-- Essential mappings from your config
keymap.set('n', '<leader>q', '<cmd>q<cr>')
keymap.set('n', '<leader>w', '<cmd>w<cr>')
keymap.set('n', '<leader>x', '<cmd>x<cr>')
keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set('n', '<c-e>', '<cmd>NvimTreeToggle<cr>')

keymap.set('i', '“', '<ESC>')
keymap.set('v', '“', '<ESC>')

keymap.set('n', 'Q', '<nop>')

keymap.set('n', '<c-a>', 'gg<S-v>G')
keymap.set('n', 'å', 'gg<S-v>G')

keymap.set('n', '<leader>s', ':vsplit<Return><C-w>w', { silent = true })
keymap.set('n', 'f', '<C-w>w')

keymap.set('n', 'H', '^')
keymap.set('n', 'L', '$')

keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-u>', '<C-u>zz')
keymap.set('n', 'n', 'nzzzv')
keymap.set('n', 'N', 'Nzzzv')

keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use { "catppuccin/nvim", as = "catppuccin" }

    use 'nvim-lua/plenary.nvim'

    use 'axelvc/template-string.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    }

    use({
        'akinsho/toggleterm.nvim',
        tag = '*'
    })

    use {
        'nvim-tree/nvim-tree.lua',
    }

    -- surround
    use 'tpope/vim-surround'
    use 'windwp/nvim-ts-autotag'
    use 'windwp/nvim-autopairs'
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- lsp/cmp
    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim' }
    use({ 'neovim/nvim-lspconfig' })
    use({ 'hrsh7th/nvim-cmp' })
    use({ 'hrsh7th/cmp-nvim-lsp' })
    use({ 'hrsh7th/cmp-buffer' })
    use 'L3MON4D3/LuaSnip'

    -- treesitter
    use 'nvim-treesitter/nvim-treesitter'

    -- colorscheme
    use 'bluz71/vim-moonfly-colors'

    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- telescope
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
keymap.set('n', '<leader>f', builtin.find_files, {})
keymap.set('n', '<leader>g', builtin.live_grep, {})
require('telescope').setup {
    pickers = {
        find_files = {
            hidden = true
        },
        grep_string = {
            additional_args = { "--hidden" }
        },
        live_grep = {
            additional_args = { "--hidden" }
        },
    },
    defaults = {
        path_display = { 'smart' },
        mappings = {
            i = {
                ["<esc>"] = actions.close
            }
        }
    },
    layout_config = {
        horizontal = {
            preview_cutoff = 100,
            preview_width = 0.6
        }
    }
}

-- toggleterm setup
require('toggleterm').setup({
    direction = 'float',
    open_mapping = [[«]]
})

-- nvimtree setup
require('nvim-tree').setup({
    sort_by = "case_sensitive",
    filters = {
        custom = { '^.git$', '^node_modules$' }
    },
    actions = {
        open_file = {
            quit_on_open = true
        }
    },
    update_focused_file = {
        enable = true,
        update_cwd = true
    },
    git = {
        enable = false
    },
    log = {
        enable = true,
        types = {
            diagnostics = true
        }
    },
    diagnostics = {
        enable = true,
        show_on_dirs = false,
        debounce_delay = 50,
        icons = {
            hint = '',
            info = '',
            warning = '',
            error = ''
        }
    },
})

-- lsp setup
-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})

require 'lspconfig'.lua_ls.setup {}
require 'lspconfig'.clangd.setup {}
require 'lspconfig'.ts_ls.setup {}
require 'lspconfig'.pyright.setup {}
-- require'lspconfig'.csharp_ls.setup{}

local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' }
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-c>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<c-d>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select
        }), { 'i', 'c' }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select
        }), { 'i', 'c' }),
        ['<c-b>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" })
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'path' },
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                buffer = '[Buffer]',
                nvim_lsp = '[LSP]',
                luasnip = '[Snippet]',
                path = '[Path]',
                ['vim-dadbod-completion'] = '[DB]',
            })[entry.source.name]
            return vim_item
        end,
    },
})

require("luasnip/loaders/from_vscode").load {
    paths = vim.fn.stdpath "config" .. "/snippets",
}

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = { 'lua_ls', 'rust_analyzer', 'ts_ls', 'pyright', 'clangd' },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})

local buffer_autoformat = function(bufnr)
    local group = 'lsp_autoformat'
    vim.api.nvim_create_augroup(group, { clear = false })
    vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

    vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        group = group,
        desc = 'LSP format on save',
        callback = function()
            -- note: do not enable async formatting
            vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
        end,
    })
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local id = vim.tbl_get(event, 'data', 'client_id')
        local client = id and vim.lsp.get_client_by_id(id)
        if client == nil then
            return
        end

        -- make sure there is at least one client with formatting capabilities
        if client.supports_method('textDocument/formatting') then
            buffer_autoformat(event.buf)
        end
    end
})

-- treesitter
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "lua", "typescript", "javascript", "markdown", "python", "rust" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,
    },
}

-- tag close
require('nvim-ts-autotag').setup({
    opts = {
        -- Defaults
        enable_close = true,          -- Auto close tags
        enable_rename = true,         -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
    },
})

require('template-string').setup({
    filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'python', 'cpp' }, -- filetypes where the plugin is active
    jsx_brackets = true,                                                                               -- must add brackets to jsx attributes
    remove_template_string = false,                                                                    -- remove backticks when there are no template string
    restore_quotes = {
        -- quotes used when "remove_template_string" option is enabled
        normal = [[']],
        jsx = [["]],
    },
})

require('nvim-autopairs').setup({
    disable_filetype = { 'TelescopePrompt', 'vim' }
})

-- colorscheme
-- vim.cmd [[colorscheme moonfly]]
vim.cmd.colorscheme "catppuccin-latte"
