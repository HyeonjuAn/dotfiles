vim.g.gruvbox_material_diagnostic_line_highlight = 1
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
vim.g.gruvbox_material_diagnostic_text_highlight = 1
vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_foreground = 'hard'
vim.cmd('colorscheme gruvbox-material')

-- vim.g.everforest_diagnostic_line_highlight = 1
-- vim.g.everforest_dim_inactive_windows = 1
-- vim.cmd('colorscheme everforest')

-- vim.cmd('colorscheme ron')
-- vim.cmd('hi Normal guibg=#0C0C0C')
-- vim.cmd('hi SignColumn guibg=#0C0C0C')
-- vim.cmd('hi FoldColumn guibg=#0C0C0C')

vim.fn.sign_define({
    {
        name = 'DiagnosticSignError',
        text = '',
        texthl = 'DiagnosticSignError',
        linehl = 'ErrorLine',
    },
    {
        name = 'DiagnosticSignWarn',
        text = '',
        texthl = 'DiagnosticSignWarn',
        linehl = 'WarningLine',
    },
    {
        name = 'DiagnosticSignInfo',
        text = '',
        texthl = 'DiagnosticSignInfo',
        linehl = 'InfoLine',
    },
    {
        name = 'DiagnosticSignHint',
        text = '',
        texthl = 'DiagnosticSignHint',
        linehl = 'HintLine',
    },
})
