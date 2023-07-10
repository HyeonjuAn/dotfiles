require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    -- 'sumneko_lua',
    'lua_ls',
    'tsserver',
  },
  automatic_installation = true,
})
